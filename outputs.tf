# ALB DNS Name
output "alb_dns_name" {
  value = module.alb.alb_dns_name
}

# RDS Endpoint
output "db_endpoint" {
  value = module.database.db_endpoint
}

# ASG Name
output "asg_name" {
  value = module.compute.asg_name
}
