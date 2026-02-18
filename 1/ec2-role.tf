module "ec2_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role"
  version = "5.39.0"

  name = "ec2-application-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  inline_policies = {
    ec2_application_policy = jsonencode({
      Version = "2012-10-17"
      Statement = [

        # -------------------------
        # ECR Write Access
        # -------------------------
        {
          Effect = "Allow"
          Action = [
            "ecr:GetAuthorizationToken",
            "ecr:BatchCheckLayerAvailability",
            "ecr:GetDownloadUrlForLayer",
            "ecr:BatchGetImage",
            "ecr:PutImage",
            "ecr:InitiateLayerUpload",
            "ecr:UploadLayerPart",
            "ecr:CompleteLayerUpload"
          ]
          Resource = "*"
        },

        # -------------------------
        # S3 Write Access
        # -------------------------
        {
          Effect = "Allow"
          Action = [
            "s3:PutObject",
            "s3:PutObjectAcl"
          ]
          Resource = "arn:aws:s3:::your-bucket-name/*"
        },

        # -------------------------
        # DB Write Access (RDS Example)
        # -------------------------
        {
          Effect = "Allow"
          Action = [
            "rds-db:connect"
          ]
          Resource = "*"
        },

        # -------------------------
        # CloudWatch Read Access
        # -------------------------
        {
          Effect = "Allow"
          Action = [
            "cloudwatch:GetMetricData",
            "cloudwatch:ListMetrics",
            "logs:DescribeLogGroups",
            "logs:GetLogEvents"
          ]
          Resource = "*"
        }
      ]
    })
  }

  create_instance_profile = true
}
