# Define Instance Type Variable
variable "instance_type" {
  description = "Type of AWS EC2 instance"
  type        = string
  default     = "t3.micro"
}

# Define Subnet ID Variable
variable "subnet_id" {
  description = "Subnet ID where the instance will be launched"
  type        = string
}

# Define Security Group ID Variable
variable "security_group_id" {
  description = "Security Group ID to associate with the instance"
  type        = string
}