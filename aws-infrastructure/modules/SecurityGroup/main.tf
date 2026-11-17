#trivy:ignore:AWS-0104 Fargate task needs outbound for Docker Hub pull, CloudWatch logs and DB
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

resource "aws_security_group" "rds_sg" {
  name        = "${var.project_name}-rds-sg"
  description = "Security group for the RDS MySQL instance"
  vpc_id      = var.vpc_id

  ingress {
    description     = "MySQL from the ECS service only"
    from_port       = var.rds_port
    to_port         = var.rds_port
    protocol        = "tcp"
    security_groups = [aws_security_group.url_shortener_sg.id]
  }

  tags = {
    Name = "${var.project_name}-rds-sg"
  }
}