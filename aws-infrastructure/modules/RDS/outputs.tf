output "address" {
  description = "Hostname of the RDS instance (use this as DB_HOST)"
  value       = aws_db_instance.main.address
}

output "port" {
  description = "Port of the RDS instance"
  value       = aws_db_instance.main.port
}

output "db_name" {
  description = "Name of the initial database"
  value       = aws_db_instance.main.db_name
}

output "db_username" {
  description = "Master username"
  value       = aws_db_instance.main.username
}

output "master_user_secret_arn" {
  description = "ARN of the Secrets Manager secret holding the master password"
  value       = aws_db_instance.main.master_user_secret[0].secret_arn
}