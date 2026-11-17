resource "aws_db_subnet_group" "main" {
  name       = "${var.project_name}-db-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "${var.project_name}-db-subnet-group"
  }
}


resource "aws_db_instance" "main" {
  identifier = "${var.project_name}-db"

  engine         = "mysql"
  engine_version = var.engine_version
  instance_class = var.instance_class

  allocated_storage = var.allocated_storage
  storage_type      = "gp3"
  storage_encrypted = true

  db_name  = var.db_name
  username = var.db_username

  # RDS generates the master password and keeps it in Secrets Manager.
  # It never appears in Terraform code, variables or plan output.
  manage_master_user_password = true

  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [var.security_group_id]
  publicly_accessible    = false
  multi_az               = var.multi_az

  backup_retention_period    = var.backup_retention_period
  auto_minor_version_upgrade = true

  deletion_protection       = var.deletion_protection
  skip_final_snapshot       = true
  final_snapshot_identifier = "${var.project_name}-db-final"

  tags = {
    Name = "${var.project_name}-db"
  }
}