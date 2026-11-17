variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_availability_zone" {
  description = "Availability zone for the public subnet"
  type        = string
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for the private subnets (RDS needs at least 2 AZs)"
  type        = list(string)
}

variable "private_availability_zones" {
  description = "Availability zones for the private subnets, same order as private_subnet_cidrs"
  type        = list(string)
}