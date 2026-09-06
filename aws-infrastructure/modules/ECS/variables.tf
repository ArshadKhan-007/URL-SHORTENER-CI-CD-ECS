variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID where ECS tasks will run"
  type        = string
}

variable "security_group_id" {
  description = "Security group ID attached to ECS tasks"
  type        = string
}

variable "execution_role_arn" {
  description = "ARN of the ECS task execution IAM role"
  type        = string
}

variable "container_image" {
  description = "Docker image used by the ECS container"
  type        = string
}

variable "container_port" {
  description = "Port on which the application listens"
  type        = number
}

variable "task_cpu" {
  description = "CPU units allocated to the ECS task"
  type        = number
  default     = 256
}

variable "task_memory" {
  description = "Memory in MB allocated to the ECS task"
  type        = number
  default     = 512
}

variable "desired_count" {
  description = "Number of ECS tasks to run"
  type        = number
  default     = 1
}