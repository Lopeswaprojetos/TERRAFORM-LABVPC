# Variáveis para a VPC
variable "vpc_cidr" {
  description = "CIDR block para a VPC"
  type        = string
  default     = "10.0.0.0/16"
}

# Variáveis para Subnets Públicas
variable "public_subnet_cidrs" {
  description = "CIDR blocks para as subnets públicas"
  type        = list(string)
  default     = ["10.0.0.0/24", "10.0.2.0/24"]
}

variable "availability_zones" {
  description = "Availability Zones para as subnets"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

# Variáveis para Subnets Privadas
variable "private_subnet_cidrs" {
  description = "CIDR blocks para as subnets privadas"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.3.0/24"]
}

# Variáveis para a instância EC2
variable "instance_type" {
  description = "Tipo de instância EC2"
  type        = string
  default     = "t3.micro"
}

variable "ami_id" {
  description = "AMI ID para a instância EC2"
  type        = string
  default     = "ami-0c55b159cbfafe1f0"  # Amazon Linux 2 AMI ID
}

# Variável para a Região AWS
variable "aws_region" {
  description = "Região AWS"
  type        = string
  default     = "us-east-1"
}
