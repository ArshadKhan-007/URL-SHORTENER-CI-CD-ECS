variable "private_subnet_ids" {
  description = "Private subnet IDs for the DB subnet group (at least 2 AZs)"
  type        = list(string)
}

variable "security_group_id" {
  description = "Security group ID attached to the RDS instance"
  type        = string
}

variable "db_name" {
  description = "Name of the initial database"
  type        = string
}

variable "db_username" {
  description = "Master username"
  type        = string
}

variable "engine_version" {
  description = "MySQL engine version"
  type        = string
}

variable "instance_class" {
  description = "RDS instance class"
  type        = string
}

variable "allocated_storage" {
  description = "Storage in GiB"
  type        = number
}

variable "multi_az" {
  description = "Run a standby in a second AZ"
  type        = bool
}

variable "backup_retention_period" {
  description = "Days to keep automated backups"
  type        = number
}

variable "deletion_protection" {
  description = "Block deletion of the instance until this is set to false"
  type        = bool
}

variable "project_name" {
  description = "Name of the project"
  type        = string
}