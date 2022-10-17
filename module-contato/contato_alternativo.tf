
resource "aws_account_alternate_contact" "billing" {

  alternate_contact_type = "BILLING"

  name          = "Faturamento UOLDIVEO"
  title         = "AWS-Faturamento-Abuse"
  email_address = "${var.email_billing}"
  phone_number  = "${var.telefone_billing}"
}


resource "aws_account_alternate_contact" "operations" {

  alternate_contact_type = "OPERATIONS"

  name          = "Operação UOLDIVEO"
  title         = "AWS-Operação-Abuse"
  email_address = "${var.email_operations}"
  phone_number  = "${var.telefone_operations}"
}


resource "aws_account_alternate_contact" "securty" {

  alternate_contact_type = "SECURITY"

  name          = "Abuse UOL"
  title         = "AWS-Seguranca-Abuse"
  email_address = "${var.email_securty}"
  phone_number  = "${var.telefone_securty}"
}