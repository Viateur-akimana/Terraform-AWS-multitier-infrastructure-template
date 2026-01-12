variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "private_db_subnet_ids" {
  description = "List of private DB subnet IDs"
  type        = list(string)
}

variable "security_group_id" {
  description = "Security Group ID for the database"
  type        = string
}

variable "db_name" {
  description = "Database name"
  type        = string

}

variable "db_username" {
  description = "Database username"
  type        = string
}

variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "project_name" {
  description = "Project name"
  type        = string
}

variable "owner" {
  description = "Owner of the resources"
  type        = string
}
