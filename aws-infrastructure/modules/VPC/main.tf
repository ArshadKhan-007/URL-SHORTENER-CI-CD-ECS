resource "aws_vpc" "url_shortener_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.project_name}-vpc"
  }
}


resource "aws_internet_gateway" "url_shortener_igw" {
  vpc_id = aws_vpc.url_shortener_vpc.id

  tags = {
    Name = "${var.project_name}-igw"
  }
}

#trivy:ignore:AWS-0164 Public subnet by design; avoids NAT Gateway cost for this learning project
resource "aws_subnet" "url_shortener_public_subnet" {
  vpc_id                  = aws_vpc.url_shortener_vpc.id
  cidr_block              = var.public_subnet_cidr
  availability_zone       = var.public_availability_zone
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-public-subnet"
    Tier = "public"
  }
}

resource "aws_subnet" "url_shortener_private_subnet" {
  count                   = length(var.private_subnet_cidrs)
  vpc_id                  = aws_vpc.url_shortener_vpc.id
  cidr_block              = var.private_subnet_cidrs[count.index]
  availability_zone       = var.private_availability_zones[count.index]
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.project_name}-private-subnet-${count.index + 1}"
    Tier = "private"
  }
}


resource "aws_route_table" "public" {
  vpc_id = aws_vpc.url_shortener_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.url_shortener_igw.id
  }

  tags = {
    Name = "${var.project_name}-public-rt"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.url_shortener_vpc.id

  tags = {
    Name = "${var.project_name}-private-rt"
  }
}


resource "aws_route_table_association" "public_subnet_association" {
  subnet_id      = aws_subnet.url_shortener_public_subnet.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private_subnet_association" {
  count          = length(var.private_subnet_cidrs)
  subnet_id      = aws_subnet.url_shortener_private_subnet[count.index].id
  route_table_id = aws_route_table.private.id
}