variable "aws_region" {
  type        = string
  description = "Preecha a região a ser usada."
  default     = "us-east-1"
}

#-----------------------------------------------------
variable "aws_profile" {
  type        = string
  description = "Informar o profile configurado no aws cli"
  default     = "payer-clickbus"
}

# variable "aws_account_id" {
#   type        = number
#   description = ""
#   default     = 060697273175
# }


variable "registro" {
  type        = map(string)
  description = "Tags do terraform para criar payer."

  default = {
    "Owner"       = "Compass-cloud-n1"
    "Environment" = "Payer-ECAM-Partnet-led"
    "ManagedBy"   = "Terraform"
  }
}