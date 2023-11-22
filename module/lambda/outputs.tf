output "lambda_func" {
    value = aws_lambda_function.demo_lambda.function_name
}

output "lambda_func_arn" {
    value = aws_lambda_function.demo_lambda.arn
}

output "lambda_func_invoke_arn" {
    value = aws_lambda_function.demo_lambda.invoke_arn
}