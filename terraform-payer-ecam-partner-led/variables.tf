variable "aws_region" {
  type        = string
  description = "Preecha a região a ser usada."
  default     = "us-east-1"
}

#-----------------------------------------------------
variable "aws_profile" {
  type        = string
  description = "Informar o profile configurado no aws cli"
  default     = "Digite o seu"
}

variable "root_details" {
  type        = string
  description = "Preencher com o target_ID do organizarion - root"
  default     = "Digite o seu"
}

variable "registro" {
  type        = map(string)
  description = "Tags do terraform para criar payer."

  default = {
    "Owner"       = "Compass-cloud-n1"
    "Environment" = "Payer-ECAM-Partnet-led"
    "ManagedBy"   = "Terraform"
  }
}

variable "id_account_cross" {
  type        = number
  description = "Account ID da role de CrossAccount"
  default     = "766581111222"

  #   default - payer-geral  = 471784020190
  #   default - payer-interna = 766581111222
}