output "s3_bucket_domain" {
  value = aws_s3_bucket.s3_bucket.bucket_regional_domain_name
}
output "s3_bucket_arn" {
  value =  aws_s3_bucket.s3_bucket.arn
}

output "s3_bucket_name" {
  value = aws_s3_bucket.s3_bucket.bucket
}