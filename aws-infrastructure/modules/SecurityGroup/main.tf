resource "aws_security_group" "url_shortener_sg" {
  name        = "${var.project_name}-sg"
  description = "Security group for URL Shortener ECS service"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow HTTP traffic to application"
    from_port   = var.app_port
    to_port     = var.app_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-sg"
  }
}