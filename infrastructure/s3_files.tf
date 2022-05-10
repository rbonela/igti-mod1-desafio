resource "aws_s3_object" "format_code" {
  bucket = "s3://rb-desafio-prod-raw-zone/"
  key    = "s3://rb-desafio-prod-raw-zone/emr-code/pyspark/format_data.ipynb"
  acl    = "private"
  source = "../scripts/pyspark/format_data.ipynb"
  etag   = filemd5("../scripts/pyspark/format_data.ipynb")
}
