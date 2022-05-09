# Backend configuration require an AWS storage bucket
terraform {
  backend "s3" {
    bucket = "terraform-state-rb"
    key    = "state/mod1/desafio/terraform.tfstate"
    region = "us-east-2"
  }
}