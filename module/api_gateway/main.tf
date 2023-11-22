
# resource "aws_internet_gateway" "vpc" {
#   vpc_id = var.vpc_id
#   tags = {
#     Name        = "${var.vpc_name}-${var.environment}"
#     environment = var.environment
#   }
# }

resource "aws_api_gateway_rest_api" "igw_lambda" {
  name = "rest_api_${var.environment}" 

}

resource "aws_api_gateway_method" "proxy_root" {
  rest_api_id =  "${aws_api_gateway_rest_api.igw_lambda.id}"
  resource_id =  "${aws_api_gateway_rest_api.igw_lambda.root_resource_id}"
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "lambda" {
  rest_api_id = "${aws_api_gateway_rest_api.igw_lambda.id}"
  resource_id = "${aws_api_gateway_method.proxy_root.resource_id}"
  http_method = "${aws_api_gateway_method.proxy_root.http_method}" 
  
  uri = "${var.lambda_func_invoke_arn}"
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
}

resource "aws_api_gateway_deployment" "demo_api_gw_develop" {
  depends_on = [
    "aws_api_gateway_integration.lambda",
  ]

  rest_api_id = "${aws_api_gateway_rest_api.igw_lambda.id}"
  stage_name  = "test"
}

resource "aws_lambda_permission" "apigw" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_func
  principal     = "apigateway.amazonaws.com"
  source_arn = "${aws_api_gateway_rest_api.igw_lambda.execution_arn}/*/*"
}