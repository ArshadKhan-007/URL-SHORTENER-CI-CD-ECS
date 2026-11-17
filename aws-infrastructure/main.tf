module "vpc" {
  source = "./modules/VPC"

  project_name             = var.project_name
  vpc_cidr                 = var.vpc_cidr
  public_availability_zone = var.public_availability_zone
  public_subnet_cidr       = var.public_subnet_cidr

  private_subnet_cidrs       = var.private_subnet_cidrs
  private_availability_zones = var.private_availability_zones
}


module "security_group" {
  source = "./modules/SecurityGroup"

  project_name = var.project_name
  vpc_id       = module.vpc.vpc_id
  app_port     = var.app_port
  rds_port     = var.rds_port
}


module "rds" {
  source = "./modules/RDS"

  project_name       = var.project_name
  private_subnet_ids = module.vpc.private_subnet_ids
  security_group_id  = module.security_group.rds_security_group_id

  db_name                 = var.db_name
  db_username             = var.db_username
  engine_version          = var.db_engine_version
  instance_class          = var.db_instance_class
  allocated_storage       = var.db_allocated_storage
  multi_az                = var.db_multi_az
  backup_retention_period = var.db_backup_retention_period
  deletion_protection     = var.db_deletion_protection
}


module "iam" {
  source = "./modules/IAM"

  project_name  = var.project_name
  db_secret_arn = module.rds.master_user_secret_arn
}


module "ecs" {
  source = "./modules/ECS"

  project_name       = var.project_name
  aws_region         = var.aws_region
  subnet_id          = module.vpc.public_subnet_id
  security_group_id  = module.security_group.security_group_id
  execution_role_arn = module.iam.execution_role_arn
  container_image    = var.container_image
  container_port     = var.app_port

  db_host       = module.rds.address
  db_port       = module.rds.port
  db_name       = module.rds.db_name
  db_username   = module.rds.db_username
  db_secret_arn = module.rds.master_user_secret_arn

  task_cpu      = 256
  task_memory   = 512
  desired_count = 1
}