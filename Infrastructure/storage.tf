resource "aws_s3_bucket" "datalake" {
  # Parâmetros de configuração dos recursos escolhidos
  bucket = "${var.bucket_name}"

  tags = local.common_tags
}

resource "aws_s3_bucket_acl" "acl_privacy" {
  bucket = aws_s3_bucket.datalake.id
  acl    = "private"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "tf_encryption" {
  bucket = aws_s3_bucket.datalake.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}