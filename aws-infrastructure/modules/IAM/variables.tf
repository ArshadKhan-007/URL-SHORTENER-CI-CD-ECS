variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "db_secret_arn" {
  description = "ARN of the Secrets Manager secret the task must be able to read"
  type        = string
}