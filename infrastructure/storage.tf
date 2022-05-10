resource "aws_s3_bucket" "buckets" {
  for_each =  toset(var.bucket_names)
  bucket = "${var.prefix}-${each.key}"

  tags = local.common_tags
}

resource "aws_s3_bucket_acl" "acl_privacy" {
  for_each = aws_s3_bucket.buckets
  bucket = aws_s3_bucket.buckets[each.key].id
  acl    = "private"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "tf_encryption" {
  for_each = aws_s3_bucket.buckets
  bucket = aws_s3_bucket.buckets[each.key].id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# resource "null_resource" "fn_example_script" {
#   triggers = {
#     always_run = timestamp()
#   }

#   provisioner "local-exec" {
#     command = "zip -rj ../functions/fn_extract_rais.zip ../functions/fn_extract_rais"
#   }
# }

