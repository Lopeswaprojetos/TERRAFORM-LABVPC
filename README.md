## Projeto Terraform VPC - AWS

## Arquitetura

A imagem abaixo descreve a arquitetura da infraestrutura provisionada por este projeto:

![Diagrama VPC](https://github.com/Lopeswaprojetos/TERRAFORM-LABVPC/blob/main/DIAGRAMA%20-%20VPC%20-%20EC2.png)



## Descrição do Projeto

Este projeto foi criado para provisionar e gerenciar infraestrutura na AWS utilizando o Terraform. Ele segue as melhores práticas de Infrastructure as Code (IaC) e foi desenhado para ser modular e reutilizável.

## Arquitetura
A infraestrutura criada por este projeto inclui:

**Internet Gateway:** Permite a comunicação entre a VPC e a internet.

**NAT Gateway:** Fornece acesso à internet para instâncias em subnets privadas.

**Application Load Balancer:** Distribui o tráfego entre as instâncias em diferentes zonas de disponibilidade.

**Auto Scaling Group:** Garante que a aplicação tenha a capacidade necessária para lidar com a carga de trabalho, escalando automaticamente.

**Instâncias EC2:** Servidores virtuais para rodar a aplicação, distribuídos em subnets públicas e privadas.

## Estrutura do Projeto
**main.tf:** Arquivo principal com a definição dos recursos.

**variables.tf:** Definição de variáveis de entrada para o projeto.

**outputs.tf:** Definição das saídas que o Terraform vai gerar após a criação da infraestrutura.

**providers.tf:** Configuração dos provedores (neste caso, AWS).

**terraform.tfvars:** Variáveis específicas do ambiente que são carregadas automaticamente pelo Terraform.

**modules/:** Diretório contendo módulos reutilizáveis.

## Pré-requisitos
Antes de iniciar, você deve ter:

Terraform instalado na sua máquina.

Uma conta na AWS.

Configurações de credenciais AWS (aws configure) configuradas.



## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.65.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_eip.nat_eip](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_instance.wagner_server](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_internet_gateway.igw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_nat_gateway.nat_gw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_route_table.private_route_table](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.public_route_table](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.private_subnet_1_assoc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.private_subnet_2_assoc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.public_subnet_1_assoc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.public_subnet_2_assoc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_security_group.wagner_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_subnet.private_subnet_1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.private_subnet_2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.public_subnet_1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.public_subnet_2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.lab_wag_vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ami_id"></a> [ami\_id](#input\_ami\_id) | AMI ID para a instância EC2 | `string` | `"ami-0c55b159cbfafe1f0"` | no |
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | Availability Zones para as subnets | `list(string)` | <pre>[<br>  "us-east-1a",<br>  "us-east-1b"<br>]</pre> | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | Região AWS | `string` | `"us-east-1"` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Tipo de instância EC2 | `string` | `"t3.micro"` | no |
| <a name="input_private_subnet_cidrs"></a> [private\_subnet\_cidrs](#input\_private\_subnet\_cidrs) | CIDR blocks para as subnets privadas | `list(string)` | <pre>[<br>  "10.0.1.0/24",<br>  "10.0.3.0/24"<br>]</pre> | no |
| <a name="input_public_subnet_cidrs"></a> [public\_subnet\_cidrs](#input\_public\_subnet\_cidrs) | CIDR blocks para as subnets públicas | `list(string)` | <pre>[<br>  "10.0.0.0/24",<br>  "10.0.2.0/24"<br>]</pre> | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | CIDR block para a VPC | `string` | `"10.0.0.0/16"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ec2_instance_id"></a> [ec2\_instance\_id](#output\_ec2\_instance\_id) | ID da instância EC2 criada. |
| <a name="output_ec2_public_ip"></a> [ec2\_public\_ip](#output\_ec2\_public\_ip) | O IP público da instância EC2. |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | ID da VPC criada. |
<!-- END_TF_DOCS -->
