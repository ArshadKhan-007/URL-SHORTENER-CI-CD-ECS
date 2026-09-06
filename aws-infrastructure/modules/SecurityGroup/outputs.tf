output "security_group_id" {
  description = "ID of the application security group"
  value       = aws_security_group.url_shortener_sg.id
}