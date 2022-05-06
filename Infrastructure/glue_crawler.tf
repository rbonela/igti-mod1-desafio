resource "aws_glue_catalog_database" "rais" {
  name = "raisdb"
}

resource "aws_glue_crawler" "stream" {
  database_name = aws_glue_catalog_database.rais.name
  name          = "rais_processing_crawler"
  role          = aws_iam_role.glue_role.arn

  s3_target {
    path = "s3://${aws_s3_bucket.stream.bucket}/rais/"
  }

  configuration = <<EOF
{
   "Version": 1.0,
   "Grouping": {
      "TableGroupingPolicy": "CombineCompatibleSchemas" }
}
EOF

  tags = local.common_tags
}