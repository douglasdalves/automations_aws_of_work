terraform {
  required_version = ">=1.2.2"

  required_providers {
    archive = "~> 1"
    aws     = "~> 2"
  }
}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}
