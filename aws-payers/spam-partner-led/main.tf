terraform {
  required_version = ">=1.2.2"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.17.1"
    }
    template = {
      source  = "hashicorp/template"
      version = "2.2.0"
    }
  }
}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

locals {
  now         = timestamp()
  brasilia_tz = timeadd(local.now, "-3h")
  date_br     = formatdate("DD/MM/YYYY", local.brasilia_tz)
}

locals {
  common_tags = {
    CreatedDate = local.brasilia_tz
  }
}

### Get Account id current
data "aws_caller_identity" "current" {}

########################
## Chamada de Modulos ##
########################

module "contato" {
  source = "../../module-contato"
}

module "role_crossAccount" {
  source            = "../../module-iam_role"
  cross_account_arn = var.id_account_cross
}

module "trails-s3-logs" {
  source = "../../module-trails-s3-logs"
}

module "grupo_admin" {
  source = "../../module-iam_group"
}

module "organization_scp" {
  source = "../../module-polices-organization"
}