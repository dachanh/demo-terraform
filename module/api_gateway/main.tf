
resource "aws_internet_gateway" "vpc" {
  vpc_id = var.vpc_id
  tags = {
    Name        = "${var.vpc_name}-${var.environment}"
    environment = var.environment
  }
}