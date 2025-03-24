# Ensure internet connectivity
resource "aws_internet_gateway" "igw_eks" {
  vpc_id = aws_vpc.eks_vpc.id
}

# Create subnets
resource "aws_subnet" "eks_public_subnets" {
  for_each = toset(var.public_subnets)

  vpc_id     = aws_vpc.main.id
  cidr_block = each.value
}

# Create route table
resource "aws_route_table" "eks_public_route_table" {
  vpc_id = aws_vpc.eks_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_eks.id
  }
}

# Associate route table to all public subnets
resource "aws_route_table_association" "eks_public_rtb_association" {
  for_each = aws_subnet.eks_public_subnets

  subnet_id      = each.value.id
  route_table_id = aws_route_table.eks_public_route_table.id
}
