variable "registro_polices" {
  type        = map(string)
  description = "Tags do terraform para criar payer."

  default = {
    "Owner"       = "Compass-cloud-n1"
    "Environment" = "Payer-Partnet-led"
    "ManagedBy"   = "Terraform"
  }
}