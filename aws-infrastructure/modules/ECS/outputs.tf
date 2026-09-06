output "cluster_id" {
  description = "ID of the ECS cluster"
  value       = aws_ecs_cluster.main-cluster.id
}

output "cluster_name" {
  description = "Name of the ECS cluster"
  value       = aws_ecs_cluster.main-cluster.name
}

output "service_id" {
  description = "ID of the ECS service"
  value       = aws_ecs_service.url-shortener-service.id
}

output "service_name" {
  description = "Name of the ECS service"
  value       = aws_ecs_service.url-shortener-service.name
}

output "task_definition_arn" {
  description = "ARN of the ECS task definition"
  value       = aws_ecs_task_definition.url-shortener-task.arn
}

output "task_definition_family" {
  description = "Family name of the ECS task definition"
  value       = aws_ecs_task_definition.url-shortener-task.family
}

output "log_group_name" {
  description = "CloudWatch log group name"
  value       = aws_cloudwatch_log_group.url-shortener-logs.name
}