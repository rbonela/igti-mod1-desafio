resource "aws_s3_object" "format_code" {
  bucket = aws_s3_bucket.buckets[1].id
  key    = "emr-code/pyspark/format_data.ipynb"
  acl    = "private"
  source = "../scripts/pyspark/format_data.ipynb"
  etag   = filemd5("../scripts/pyspark/format_data.ipynb")
}
