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

variable "public_availability_zone" {
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

variable "private_subnet_cidrs" {
  description = "CIDR blocks for the private subnets (RDS needs at least 2 AZs)"
  type        = list(string)
  default     = ["10.0.10.0/24", "10.0.11.0/24"]
}

variable "private_availability_zones" {
  description = "Availability zones for the private subnets, same order as private_subnet_cidrs"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "db_name" {
  description = "Name of the initial database"
  type        = string
  default     = "url_shortener_db"
}

variable "db_username" {
  description = "Master username"
  type        = string
  default     = "admin"
}

variable "db_engine_version" {
  description = "MySQL engine version"
  type        = string
  default     = "8.4"
}

variable "db_instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t4g.micro"
}

variable "db_allocated_storage" {
  description = "Storage in GiB"
  type        = number
  default     = 20
}

variable "db_multi_az" {
  description = "Run a standby in a second AZ"
  type        = bool
  default     = false
}

variable "db_backup_retention_period" {
  description = "Days to keep automated backups"
  type        = number
  default     = 3
}

variable "db_deletion_protection" {
  description = "Block deletion of the instance until this is set to false"
  type        = bool
  default     = false
}

variable "rds_port" {
  description = "Port on which the RDS MySQL instance listens"
  type        = number
  default     = 3306
}