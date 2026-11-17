output "vpc_id" {
  description = "ID of the VPC"
  value       = module.vpc.vpc_id
}

output "public_subnet_id" {
  description = "ID of the public subnet"
  value       = module.vpc.public_subnet_id
}

output "security_group_id" {
  description = "ID of the application security group"
  value       = module.security_group.security_group_id
}

output "ecs_cluster_id" {
  description = "ID of the ECS cluster"
  value       = module.ecs.cluster_id
}

output "ecs_cluster_name" {
  description = "Name of the ECS cluster"
  value       = module.ecs.cluster_name
}

output "ecs_service_id" {
  description = "ID of the ECS service"
  value       = module.ecs.service_id
}

output "ecs_service_name" {
  description = "Name of the ECS service"
  value       = module.ecs.service_name
}

output "task_definition_arn" {
  description = "ARN of the ECS task definition"
  value       = module.ecs.task_definition_arn
}

output "task_definition_family" {
  description = "Family of the ECS task definition"
  value       = module.ecs.task_definition_family
}

output "cloudwatch_log_group" {
  description = "CloudWatch log group used by ECS"
  value       = module.ecs.log_group_name
}

output "ecs_execution_role_arn" {
  description = "ARN of the ECS task execution role"
  value       = module.iam.execution_role_arn
}

output "private_subnet_ids" {
  description = "IDs of the private subnets"
  value       = module.vpc.private_subnet_ids
}

output "rds_address" {
  description = "RDS hostname (DB_HOST for the app)"
  value       = module.rds.address
}

output "rds_port" {
  description = "RDS port"
  value       = module.rds.port
}

output "rds_db_name" {
  description = "Initial database name"
  value       = module.rds.db_name
}

output "rds_db_username" {
  description = "RDS master username"
  value       = module.rds.db_username
}

output "rds_master_user_secret_arn" {
  description = "Secrets Manager ARN holding the RDS master password"
  value       = module.rds.master_user_secret_arn
}

output "rds_security_group_id" {
  description = "ID of the RDS security group"
  value       = module.security_group.rds_security_group_id
}