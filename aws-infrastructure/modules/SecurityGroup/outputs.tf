output "security_group_id" {
  description = "ID of the application security group"
  value       = aws_security_group.url_shortener_sg.id
}

output "rds_security_group_id" {
  description = "ID of the RDS security group"
  value       = aws_security_group.rds_sg.id
}