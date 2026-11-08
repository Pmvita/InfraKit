variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "name_prefix" {
  description = "Prefix for all resources"
  type        = string
  default     = "infrakit-dev"
}

variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
  default     = "10.0.0.0/16"
}

variable "az_count" {
  description = "Number of AZs"
  type        = number
  default     = 2
}

variable "enable_nat_gateway" {
  description = "Create NAT Gateway(s) for private subnet egress"
  type        = bool
  default     = false
}

variable "app_port" {
  description = "Application container port"
  type        = number
  default     = 80
}

variable "container_image" {
  description = "ECS container image"
  type        = string
  default     = "public.ecr.aws/docker/library/nginx:alpine"
}

variable "ecs_desired_count" {
  description = "Desired ECS task count"
  type        = number
  default     = 1
}

variable "ecs_cpu" {
  type    = number
  default = 256
}

variable "ecs_memory" {
  type    = number
  default = 512
}

variable "db_instance_class" {
  type    = string
  default = "db.t3.micro"
}

variable "db_name" {
  type    = string
  default = "appdb"
}

variable "db_username" {
  type      = string
  default   = "appadmin"
  sensitive = true
}

variable "db_password" {
  description = "RDS master password — set via tfvars or TF_VAR_db_password; never commit real secrets"
  type        = string
  sensitive   = true
}

variable "db_multi_az" {
  type    = bool
  default = false
}

variable "db_deletion_protection" {
  type    = bool
  default = false
}

variable "s3_force_destroy" {
  type    = bool
  default = true
}
