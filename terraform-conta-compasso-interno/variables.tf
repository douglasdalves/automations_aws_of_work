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

variable "cross_account_arn" {
  type    = string
  default = "arn:aws:iam::471784020190:root"
}

variable "registro" {
  type        = map(string)
  description = "Tags do terraform para contas."

  default = {
    "Owner"       = "Compass-cloud-n1"
    "Environment" = "Conta-SPAM-Partnet-led"
    "ManagedBy"   = "Terraform"
  }
}