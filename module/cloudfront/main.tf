resource "aws_cloudfront_distribution" "cloudfront" {
  origin {
    domain_name = var.s3_bucket_domain
    origin_id   = "S3Origin"
  }
}