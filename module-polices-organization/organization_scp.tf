
resource "aws_organizations_policy_attachment" "root" {
  count     = var.enable_scp ? 1 : 0
  policy_id = aws_organizations_policy.policy_supportDeny.id
  target_id = var.root_details
}

resource "aws_organizations_policy_attachment" "root1" {
  policy_id = aws_organizations_policy.policy_compassouol_recommended.id
  target_id = var.root_details
}

# Ativar se o cliente tem bloqueio de billing nas linkeds
## ----------------------------------------------------------
resource "aws_organizations_policy_attachment" "root2" {
  policy_id = aws_organizations_policy.policy_billing.id
  target_id = var.root_details
}