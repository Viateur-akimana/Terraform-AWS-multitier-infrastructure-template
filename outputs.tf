# ALB DNS Name
output "alb_dns" {
  value = module.alb.alb_dns_name
}

# RDS Endpoint
output "rds_endpoint" {
  value = module.database.db_endpoint
}

# ASG Name
output "asg_name" {
  value = module.compute.asg_name
}

# Bastion Public IP
output "bastion_public_ip" {
  value = module.compute.bastion_public_ip
}
