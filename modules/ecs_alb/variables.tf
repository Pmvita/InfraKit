variable "name_prefix" {
  description = "Prefix for resource names"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "public_subnet_ids" {
  description = "Public subnet IDs for the ALB"
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "Private subnet IDs for ECS tasks"
  type        = list(string)
}

variable "alb_security_group_id" {
  description = "Security group attached to the ALB"
  type        = string
}

variable "ecs_security_group_id" {
  description = "Security group attached to ECS tasks"
  type        = string
}

variable "execution_role_arn" {
  description = "IAM execution role ARN for ECS tasks"
  type        = string
}

variable "task_role_arn" {
  description = "IAM task role ARN for ECS tasks"
  type        = string
}

variable "container_image" {
  description = "Container image URI (e.g. public.ecr.aws/nginx/nginx:latest)"
  type        = string
  default     = "public.ecr.aws/docker/library/nginx:alpine"
}

variable "container_port" {
  description = "Port the container listens on"
  type        = number
  default     = 8080
}

variable "desired_count" {
  description = "Desired number of ECS tasks"
  type        = number
  default     = 1
}

variable "cpu" {
  description = "Fargate task CPU units"
  type        = number
  default     = 256
}

variable "memory" {
  description = "Fargate task memory (MiB)"
  type        = number
  default     = 512
}

variable "health_check_path" {
  description = "ALB target group health check path"
  type        = string
  default     = "/"
}

variable "enable_container_insights" {
  description = "Enable ECS Container Insights"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags applied to compute resources"
  type        = map(string)
  default     = {}
}
