resource "aws_s3_bucket" "s3_bucket" {
  bucket = "${var.name}-${var.environment}"
  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }
}

# resource "aws_s3_bucket" "s3_bucket_1" {
#   bucket = "${var.name}-${var.environment}-test"

# }


# resource "aws_s3_bucket_policy" "s3_policy" {
#   bucket = aws_s3_bucket.s3_bucket_1.id
#   policy = <<EOF
#         {
#           "Version": "2012-10-17",
#           "Statement": [
#             {
#               "Effect": "Allow",
#               "Principal": "*",
#               "Action": [
#                 "s3:GetObject",
#                 "s3:PutBucketPolicy",
#                 "s3:PutObject",
#                 "s3:ListBucket",
#                 "s3:*"
#               ],
#               "Resource": [
#                 "arn:aws:s3:::amacho-develop-test/*",
#                 "arn:aws:s3:::amacho-develop-test"
#               ]
#             }
#           ]
#         }
#     EOF
# }
# resource "aws_s3_bucket_object_lock_configuration" "object_lock_configuration" {
#   bucket = aws_s3_bucket.s3_bucket.id

#     object_lock_enabled = "Enabled"

#     rule {
#       default_retention {
#         mode = "GOVERNANCE"
#         days = 1
#       }
#     }

# }