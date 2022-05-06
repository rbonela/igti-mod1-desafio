provider "aws" {
  region = var.aws_region
}

# Centralizar o arquivo de controle de estado do terraform (obs.: não é possível adicionar valores de variáveis dentro do código abaixo
# na seção do terraform)
terraform {
  backend "s3" {
    bucket = "terraform-state-rb"
    key = "state/mod1/desafio/terraform.tfstate"
    region = "us-east-2"
  }
}