resource "aws_iam_policy" "Support_Deny" {
  name = "SupportDeny"

  policy = <<EOF
{
  "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : [
          "Support:*"
        ],
        "Resource" : "*",
        "Effect" : "Deny"
      }
    ]
}
EOF
}


resource "aws_iam_policy" "Policy_Billing" {
  name = "BillingDenyPolicy"

  policy = <<EOF
{
  "Version" : "2012-10-17",
    "Statement" : [
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
}
EOF
}


