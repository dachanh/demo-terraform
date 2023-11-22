resource "aws_cloudwatch_log_group" "lambda_log_group" {
  name              = "/aws/lambda/upload_image" #don't do that, don't hardcore
  retention_in_days = 7
  lifecycle {
    prevent_destroy = false
  }
}
resource "aws_lambda_function" "demo_lambda" {
    function_name = "upload_image"
    role = aws_iam_role.lambda_role.arn
    handler       = "function/lambda_function.lambda_handler"
    filename =    "function.zip"
    runtime       = "python3.8"
    memory_size = "1536"
    depends_on    = [aws_cloudwatch_log_group.lambda_log_group]
    environment {
      variables = {
        S3_BUCKET_DOMAIN= var.bucket_domain_name
        S3_BUCKET = var.bucket_name
      }
    }
}