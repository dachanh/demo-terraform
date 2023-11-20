data "aws_caller_identity" "current" {}


data "aws_iam_policy_document" "ecr_repo_policy_document" {
  statement {
    sid    = "${var.name}${var.environment}AllowPull"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = [data.aws_caller_identity.current.arn]
    }
    actions = [
      "ecr:BatchCheckLayerAvailability",
      "ecr:BatchGetImage",
      "ecr:CompleteLayerUpload",
      "ecr:GetDownloadUrlForLayer",
      "ecr:GetLifecyclePolicy",
      "ecr:InitiateLayerUpload",
      "ecr:PutImage",
      "ecr:UploadLayerPart"
    ]
  }
}

resource "aws_ecr_repository_policy" "ecr_repository_policy" {
  repository = aws_ecr_repository.ecr_repository.name
  policy     = data.aws_iam_policy_document.ecr_repo_policy_document.json
}