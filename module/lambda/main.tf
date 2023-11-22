resource "aws_lambda_function" "demo_lambda" {
    function_name = "upload_image"
    role = aws_iam_role.lambda_role.arn
    handler       = "lambda_function.lambda_handler"
    runtime       = "python3.8"
    memory_size = "1536"
    environment {
      variables = {
        S3_BUCKET= var.bucket_name
      }
    }
}