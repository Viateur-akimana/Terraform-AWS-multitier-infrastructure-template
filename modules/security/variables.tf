variable "vpc_id" {
  description = "VPC ID where the security group will be created"
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

variable "owner" {
  description = "Owner of the resources"
  type        = string
}
