output "base_url" {
    value = "${aws_api_gateway_deployment.demo_api_gw_develop.invoke_url}"
}