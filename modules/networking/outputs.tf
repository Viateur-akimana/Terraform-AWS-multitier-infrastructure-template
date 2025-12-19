#  VPC ID
output "vpc_id" {
  value = aws_vpc.main.id
}

#  Public Subnet IDs
output "public_subnet_ids" {
  value = aws_subnet.public[*].id
}

#  Private App Subnet IDs
output "private_app_subnet_ids" {
  value = aws_subnet.private_app[*].id
}

#  Private DB Subnet IDs
output "private_db_subnet_ids" {
  value = aws_subnet.private_db[*].id
}

# Route Table IDs
output "public_route_table_id" {
  value = aws_route_table.public.id
}

output "private_route_table_id" {
  value = aws_route_table.private.id
}
