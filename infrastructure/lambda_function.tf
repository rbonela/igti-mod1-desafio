resource "aws_lambda_function" "decompresss3" {
    filename      = "../functions/fn_extract_rais/package/lambda_decompress.zip"
    function_name = "rb-desafio_df_extract_rais"
    role          = aws_iam_role.lambda_extract_role.arn
    handler       = "handler.handler"
    # The filebase64sha256() function is available in Terraform 0.11.12 and later
    # For Terraform 0.11.11 and earlier, use the base64sha256() function and the file() function:
    # source_code_hash = "${base64sha256(file("../functions/fn_extract_rais.zip"))}"
    source_code_hash = filebase64sha256("../functions/fn_extract_rais/package/lambda_decompress.zip")
    runtime     = "python3.8"
    # timeout     = 900
    # memory_size = 10000
    
    tags = local.common_tags

}