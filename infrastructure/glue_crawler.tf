resource "aws_glue_catalog_database" "rais" {
  name = "raisdb"
}

resource "aws_glue_crawler" "rais" {
  database_name = aws_glue_catalog_database.rais.name
  name          = "rais_processing_crawler"
  role          = aws_iam_role.glue_role.arn

  s3_target {
    path = "s3://${var.prefix}-${var.bucket_names[1]}/rais/"
  }

  tags = local.common_tags
}