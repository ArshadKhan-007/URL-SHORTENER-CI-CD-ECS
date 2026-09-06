output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.url_shortener_vpc.id
}

output "public_subnet_id" {
  description = "ID of the public subnet"
  value       = aws_subnet.url_shortener_public_subnet.id
}

output "availability_zone" {
  description = "Availability zone used by the public subnet"
  value       = aws_subnet.url_shortener_public_subnet.availability_zone
}