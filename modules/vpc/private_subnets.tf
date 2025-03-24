# Ensure internet connectivity
resource "aws_nat_gateway" "eks_natgw" {
  subnet_id = aws_subnet.eks_public_subnets[0].id

  depends_on = [aws_internet_gateway.igw_eks]
}

# Create subnets
resource "aws_subnet" "eks_private_subnets" {
  for_each = toset(var.private_subnets)

  vpc_id     = aws_vpc.main.id
  cidr_block = each.value
}

# Create route table
resource "aws_route_table" "eks_private_route_table" {
  vpc_id = aws_vpc.eks_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.eks_natgw.id
  }
}

# Associate route table to all public subnets
resource "aws_route_table_association" "eks_private_rtb_association" {
  for_each = aws_subnet.eks_private_subnets

  subnet_id      = each.value.id
  route_table_id = aws_route_table.eks_private_route_table.id
}
