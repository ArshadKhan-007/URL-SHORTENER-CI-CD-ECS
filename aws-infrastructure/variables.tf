variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "url-shortener"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "production"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "availability_zone" {
  description = "Availability zone for the public subnet"
  type        = string
  default     = "us-east-1a"
}

variable "app_port" {
  description = "Port on which the application listens"
  type        = number
  default     = 8000
}

variable "container_image" {
  description = "Docker image used by the ECS task"
  type        = string
  default     = "arshadkhan007/url-shortener:latest"
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