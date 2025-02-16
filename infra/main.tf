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
resource "aws_ecr_repository" "my_repo" {
  name                 = var.repo_name
  image_tag_mutability = "MUTABLE"
}
