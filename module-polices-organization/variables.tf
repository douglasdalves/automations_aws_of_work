variable "registro_polices" {
  type        = map(string)
  description = "Tags do terraform para criar payer."

  default = {
    "Owner"       = "Compass-cloud-n1"
    "Environment" = "Payer-Partnet-led"
    "ManagedBy"   = "Terraform"
  }
}

variable "root_details" {
  type        = string
  description = "Preencher com o target_ID do organizarion - root"
  #default     = "Digite o seu"
}

variable "enable_scp" {
  type = bool
  #default = true
}