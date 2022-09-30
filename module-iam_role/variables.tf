
variable "cross_account_arn" {
  type    = number
  description = "Account ID da role de CrossAccount"
  #default = 471784020190
  #default = 766581111222
}

variable "registro_role" {
  type        = map(string)
  description = "Tags do terraform para contas."

  default = {
    "Owner"       = "Compass-cloud-n1"
    "ManagedBy"   = "Terraform"
  }
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