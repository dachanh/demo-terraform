terraform {
  backend "s3" {
    bucket         = "amacho-develop-terraform-tfstate"
    key            = "terraform.tfstate"
    region         = "ap-northeast-2"
    dynamodb_table = "amacho-terraform-develop-state-lock"
    role_arn       = "arn:aws:iam::096953977275:role/amcho-cuongnh-role"
    encrypt        = true
  }
}