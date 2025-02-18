variable "tfstate_s3_bucket_name" {
  type    = string
  default = "s3-sonamegpt-terraform"
}

variable "project" {
  default = "testecrimg"
}

variable "stage" {
  type        = string
  description = "Environment Name"
  default     = "dev"
}





variable "repo_name" {
  type    = string
  default = "test-ecr-repo"
}

variable "image_tag" {
  type        = string
  default     = "latest"
  description = "Which version of lambda image to use? 'latest' / 'ver_x.y.z'"
}
