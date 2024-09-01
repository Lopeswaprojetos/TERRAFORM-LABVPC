terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.65.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# VPC
resource "aws_vpc" "lab_wag_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "Lab WAG VPC"
  }
}

# Subnet Pública 1
resource "aws_subnet" "public_subnet_1" {
  vpc_id     = aws_vpc.lab_wag_vpc.id
  cidr_block = var.public_subnet_cidrs[0]
  availability_zone = var.availability_zones[0]
  tags = {
    Name = "Public Subnet 1"
  }
}

# Subnet Pública 2
resource "aws_subnet" "public_subnet_2" {
  vpc_id     = aws_vpc.lab_wag_vpc.id
  cidr_block = var.public_subnet_cidrs[1]
  availability_zone = var.availability_zones[1]
  tags = {
    Name = "Public Subnet 2"
  }
}

# Subnet Privada 1
resource "aws_subnet" "private_subnet_1" {
  vpc_id     = aws_vpc.lab_wag_vpc.id
  cidr_block = var.private_subnet_cidrs[0]
  availability_zone = var.availability_zones[0]
  tags = {
    Name = "Private Subnet 1"
  }
}

# Subnet Privada 2
resource "aws_subnet" "private_subnet_2" {
  vpc_id     = aws_vpc.lab_wag_vpc.id
  cidr_block = var.private_subnet_cidrs[1]
  availability_zone = var.availability_zones[1]
  tags = {
    Name = "Private Subnet 2"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.lab_wag_vpc.id
  tags = {
    Name = "Lab WAG IGW"
  }
}

# Tabela de Rotas Pública
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.lab_wag_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "Public Route Table"
  }
}

# Associar Subnets Públicas à Tabela de Rotas
resource "aws_route_table_association" "public_subnet_1_assoc" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public_subnet_2_assoc" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public_route_table.id
}

# NAT Gateway (para subnets privadas)
resource "aws_eip" "nat_eip" {
  vpc = true
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet_1.id
  tags = {
    Name = "Lab WAG NAT Gateway"
  }
}

# Tabela de Rotas Privada
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.lab_wag_vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }
  tags = {
    Name = "Private Route Table"
  }
}

# Associar Subnets Privadas à Tabela de Rotas
resource "aws_route_table_association" "private_subnet_1_assoc" {
  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "private_subnet_2_assoc" {
  subnet_id      = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.private_route_table.id
}

# Security Group para permitir HTTP
resource "aws_security_group" "wagner_sg" {
  vpc_id = aws_vpc.lab_wag_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "Wagner Security Group"
    Description = "Enable HTTP access"
  }
}

# Instância EC2
resource "aws_instance" "wagner_server" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.public_subnet_2.id
  security_groups             = [aws_security_group.wagner_sg.name]
  associate_public_ip_address = true

  tags = {
    Name = "Wagner Server"
  }
}
