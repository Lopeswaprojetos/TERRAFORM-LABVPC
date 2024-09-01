# Output do IP público da instância EC2
output "ec2_public_ip" {
  value       = aws_instance.wagner_server.public_ip
  description = "O IP público da instância EC2."
}

# Output do ID da VPC
output "vpc_id" {
  value       = aws_vpc.lab_wag_vpc.id
  description = "ID da VPC criada."
}

# Output do ID da instância EC2
output "ec2_instance_id" {
  value       = aws_instance.wagner_server.id
  description = "ID da instância EC2 criada."
}
