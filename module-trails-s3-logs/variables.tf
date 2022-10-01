variable "enable_cloudtrail" {
  type    = bool
  default = true
}
variable "is_multi_region_trail" {
  type    = bool
  default = false
}

variable "registro_s3" {
  type        = map(string)
  description = "Tags do terraform para contas."

  default = {
    "Owner"     = "Compass-cloud-n1"
    "trails"    = "Conta-projeto-trail"
    "ManagedBy" = "Terraform"
  }
}