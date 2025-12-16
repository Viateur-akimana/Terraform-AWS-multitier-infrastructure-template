# Output VPC ID
output "vpc_id" {
  value = aws_vpc.nss25.id
}

# Output Subnet ID
output "subnet_id" {
  value = aws_subnet.public.id
}