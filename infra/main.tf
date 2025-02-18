provider "aws" {
  region = "eu-central-1"
}

terraform {
  backend "s3" {
    bucket = var.tfstate_s3_bucket_name
    key    = "test-ecr-repo/terraform.tfstate"
    region = "eu-central-1"
  }
}

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

# ECR Repo
######################################################################

resource "aws_ecr_repository" "my_repo" {
  name                 = var.repo_name
  image_tag_mutability = "MUTABLE"
}

# Lambda fun
######################################################################

resource "aws_iam_role" "lambda_exec_role" {
  name = "role-${var.project}-lambda-${var.stage}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action    = "sts:AssumeRole",
        Effect    = "Allow",
        Principal = { Service = "lambda.amazonaws.com" }
      }
    ]
  })
}

# Attach AWS managed policy for basic Lambda execution
resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
  role       = aws_iam_role.lambda_exec_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}


resource "aws_lambda_function" "lambda_function" {
  function_name = "lambda-${var.project}-${var.stage}"
  role          = aws_iam_role.lambda_exec_role.arn
  package_type  = "Image"

  image_uri = "${data.aws_caller_identity.current.account_id}.dkr.ecr.${data.aws_region.current.name}.amazonaws.com/${var.repo_name}:${var.image_tag}"

  timeout = 900

  environment {
    variables = {
      STAGE = var.stage
    }
  }
}
