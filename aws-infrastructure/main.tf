module "vpc" {
  source = "./modules/VPC"

  project_name       = var.project_name
  vpc_cidr           = var.vpc_cidr
  availability_zone  = var.availability_zone
  public_subnet_cidr = var.public_subnet_cidr
}


module "security_group" {
  source = "./modules/SecurityGroup"

  project_name = var.project_name
  vpc_id       = module.vpc.vpc_id
  app_port     = var.app_port
}


module "iam" {
  source = "./modules/IAM"

  project_name = var.project_name
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

  task_cpu     = 256
  task_memory  = 512
  desired_count = 1
}