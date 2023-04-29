terraform {
  required_version = "1.3.9"
}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

