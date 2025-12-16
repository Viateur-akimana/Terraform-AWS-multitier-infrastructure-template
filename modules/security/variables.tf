# Define Variable for Security Group Name
variable "public_security_group_name" {
  description = "Name of the security group"
  type        = string
  default     = "allow_http_ssh"
}

# Define Variable for VPC ID
variable "vpc_id" {
  description = "VPC ID where the security group will be created"
  type        = string
}