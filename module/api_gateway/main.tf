
resource "aws_internet_gateway" "vpc" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name        = "${var.vpc_name}-${var.environment}"
    environment = var.environment
  }
}