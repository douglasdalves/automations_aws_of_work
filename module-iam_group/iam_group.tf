## ----------------------------------------------------------##
## Grupo e policy
## ----------------------------------------------------------##

resource "aws_iam_group" "group" {
  name = "admin"
}

resource "aws_iam_group_policy" "policy_admin" {
  name  = "AdministratorAccess"
  group = aws_iam_group.group.name

  policy = jsonencode({
    Version : "2012-10-17",
    Statement : [
      {
        Effect : "Allow",
        Action : "*",
        Resource : "*"
      }
    ]
  })
}


resource "aws_iam_group_policy" "Support_Deny" {
  name  = "SupportDeny"
  group = aws_iam_group.group.name

  policy = jsonencode({
    Version : "2012-10-17",
    Statement : [
      {
        "Action" : [
          "Support:*"
        ],
        "Resource" : "*",
        "Effect" : "Deny"
      }
    ]
  })
}

resource "aws_iam_group_policy" "Policy_Billing" {
  name  = "BillingDenyPolicy"
  group = aws_iam_group.group.name

  policy = jsonencode({
    Version : "2012-10-17",
    Statement : [
      {
        "Action" : [
          "ce:*",
          "aws-portal:*",
          "organizations:*",
          "Support:*",
          "pricing:*",
          "budgets:*",
          "cur:*"
        ],
        "Resource" : "*",
        "Effect" : "Deny"
      }
    ]
  })
}

## ----------------------------------------------------------##
## 
## ----------------------------------------------------------##
