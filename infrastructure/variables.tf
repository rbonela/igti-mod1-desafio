variable "aws_region" {
  default = "us-east-2"
}

variable "prefix" {
  default = "rb-desafio"
}

# Prefix configuration and project common tags
locals {
  prefix = "${var.prefix}-${terraform.workspace}"
  common_tags = {
    Project      = "RAIS"
    ManagedBy    = "Terraform"
    Owner        = "Ramon"
    BusinessUnit = "IGTI_EDC"
    Environment  = terraform.workspace
    UserEmail    = "ramonbonela@gmail.com"
  }
}

variable "bucket_names" {
  description = "Create S3 buckets with these names"
  type        = list(string)
  default = [
    "raw-zone",
    "processing-zone",
    "delivery-zone",
    "logs"
  ]
}

variable "database_names" {
  description = "Create databases with these names"
  type        = list(string)
  default = [
    "dl_raw_zone",
    "dl_processing_zone",
    "dl_delivery_zone"
  ]
}