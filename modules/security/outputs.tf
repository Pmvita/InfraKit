output "alb_security_group_id" {
  description = "Security group ID for the ALB"
  value       = aws_security_group.alb.id
}

output "ecs_security_group_id" {
  description = "Security group ID for ECS tasks"
  value       = aws_security_group.ecs.id
}

output "rds_security_group_id" {
  description = "Security group ID for RDS"
  value       = aws_security_group.rds.id
}

output "ecs_execution_role_arn" {
  description = "IAM role ARN for ECS task execution"
  value       = aws_iam_role.ecs_execution.arn
}

output "ecs_task_role_arn" {
  description = "IAM role ARN for ECS tasks (application)"
  value       = aws_iam_role.ecs_task.arn
}

output "ecs_task_role_name" {
  description = "IAM role name for attaching extra policies (e.g. S3)"
  value       = aws_iam_role.ecs_task.name
}
