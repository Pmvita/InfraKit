variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "prod"
}

variable "name_prefix" {
  description = "Prefix for all resources"
  type        = string
  default     = "infrakit-prod"
}

variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
  default     = "10.10.0.0/16"
}

variable "az_count" {
  description = "Number of AZs"
  type        = number
  default     = 3
}

variable "enable_nat_gateway" {
  description = "Create NAT Gateway(s) for private subnet egress"
  type        = bool
  default     = true
}

variable "app_port" {
  description = "Application container port"
  type        = number
  default     = 80
}

variable "container_image" {
  description = "ECS container image"
  type        = string
}

variable "ecs_desired_count" {
  description = "Desired ECS task count"
  type        = number
  default     = 2
}

variable "ecs_cpu" {
  type    = number
  default = 512
}

variable "ecs_memory" {
  type    = number
  default = 1024
}

variable "db_instance_class" {
  type    = string
  default = "db.t3.small"
}

variable "db_name" {
  type    = string
  default = "appdb"
}

variable "db_username" {
  type      = string
  sensitive = true
}

variable "db_password" {
  description = "RDS master password — set via tfvars or TF_VAR_db_password; never commit real secrets"
  type        = string
  sensitive   = true
}

variable "db_multi_az" {
  type    = bool
  default = true
}

variable "db_deletion_protection" {
  type    = bool
  default = true
}

variable "s3_force_destroy" {
  type    = bool
  default = false
}
