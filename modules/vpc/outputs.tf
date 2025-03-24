output "vpc_id" {
  value = aws_vpc.eks_vpc.id
}

output "private_subnet_ids" {
  value = [for subnet in aws_subnet.eks_private_subnets : subnet.id]
}