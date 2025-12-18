variable "instance_type" {
  description = "Type of AWS EC2 instance"
  type        = string
  default     = "t3.micro"
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs for the ASG"
  type        = list(string)
}

variable "security_group_id" {
  description = "Security Group ID for the app servers"
  type        = string
}

variable "target_group_arn" {
  description = "Target Group ARN for the ALB"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "3tier-iac"
}

variable "key_name" {
  description = "SSH key pair name"
  type        = string
  default     = "test-server-kp"
}
