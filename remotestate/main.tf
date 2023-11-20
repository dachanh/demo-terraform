provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "terrafrom-state" {
  bucket = var.bucket_name

  lifecycle {
    prevent_destroy = false
  }

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_dynamodb_table" "terraform-locks" {
  name         = var.table_terraform_locks
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}


// make document policy
data "aws_iam_policy_document" "backend_storage_policy" {
  statement {
    actions   = ["s3:ListBucket"]
    resources = [aws_s3_bucket.terrafrom-state.arn]
  }

  statement {
    actions   = ["s3:*"]
    resources = ["${aws_s3_bucket.terrafrom-state.arn}/*"]
  }
  statement {
    actions   = ["s3:*"]
    resources = ["${aws_s3_bucket.terrafrom-state.arn}"]
  }

  statement {
    actions   = ["dynamodb:GetItem", "dynamodb:PutItem", "dynamodb:DeleteItem"]
    resources = [aws_dynamodb_table.terraform-locks.arn]
  }

}

// make policy
resource "aws_iam_policy" "policy" {
  name        = "${var.name}-policy-${var.account}"
  path        = "/"
  description = "make IAM poloicy"
  policy      = data.aws_iam_policy_document.backend_storage_policy.json
}

// make iam role
resource "aws_iam_role" "backend_storge_role" {
  name = "${var.name}-${var.account}-role"
  assume_role_policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Action" : "sts:AssumeRole",
          "Principal" : {
            "AWS" : "${var.aws_iam}"
          }
          "Effect" : "Allow"
        },
        {
          "Effect" : "Allow",
          "Principal" : {
            "Service" : "ec2.amazonaws.com"
          },
          "Action" : "sts:AssumeRole"
        }
      ]
    }
  )

  tags = {
    Name = "${var.name} Role"
  }
}

// attach iam policy 

resource "aws_iam_role_policy_attachment" "policy_attachment" {
  role       = aws_iam_role.backend_storge_role.name
  policy_arn = aws_iam_policy.policy.arn
}

output "config" {
  value = {
    bucket   = var.bucket_name
    role_arn = aws_iam_role.backend_storge_role.arn
  }
}
