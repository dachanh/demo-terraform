

# variable "vpc_id" {
#     type = string
# }

# variable "vpc_name" {
#     type = string
# }

variable "environment" {
    type =  string
}

variable "lambda_func" {
    type =  string
}

variable "lambda_func_arn" {
    type = string
}
variable "lambda_func_invoke_arn" {
    type = string
}