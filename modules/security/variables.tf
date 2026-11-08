variable "name_prefix" {
  description = "Prefix for resource names"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID for security groups"
  type        = string
}

variable "alb_ingress_cidrs" {
  description = "CIDR blocks allowed to reach the ALB (HTTP/HTTPS)"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "app_port" {
  description = "Container/application port exposed by ECS tasks"
  type        = number
  default     = 8080
}

variable "db_port" {
  description = "Database port (PostgreSQL default 5432)"
  type        = number
  default     = 5432
}

variable "tags" {
  description = "Tags applied to security resources"
  type        = map(string)
  default     = {}
}
