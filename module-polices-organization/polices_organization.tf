## ----------------------------------------------------------##
## Polices do organization
## ----------------------------------------------------------##

# Compass-deny-billing

resource "aws_organizations_policy" "policy_billing" {
  name        = "Compass-deny-billing"
  description = "Policy que bloqueia o acesso ao billing pelo cliente."
  tags        = var.registro_polices

  content = <<CONTENT
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "denybilling",
      "Effect": "Deny",
      "Action": [
        "aws-portal:*",
        "cur:*",
        "ce:*",
        "budgets:*",
        "pricing:*"
      ],
      "Resource": "*",
      "Condition": {
        "ArnNotLike": {
          "aws:PrincipalArn": [
            "arn:aws:iam::*:role/aws-reserved/sso.amazonaws.com/AWSReservedSSO_CompassoCloudTeam_*",
            "arn:aws:iam::*:role/aws-reserved/sso.amazonaws.com/AWSReservedSSO_CompassoAdmins_*"
          ]
        }
      }
    }
  ]
}
CONTENT
}

# SCPCompassoUOL-SupportDeny

resource "aws_organizations_policy" "policy_supportDeny" {
  name        = "SCPCompassoUOL-SupportDeny"
  description = "SCP Compasso UOL - Support Deny"
  tags        = var.registro_polices

  content = <<CONTENT
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Deny",
      "Action": [
        "support:*",
        "ec2:ReportInstanceStatus"
      ],
      "Resource": "*",
      "Condition": {
        "ArnNotEquals": {
          "aws:PrincipalArn": [
            "arn:aws:iam::*:role/aws-reserved/sso.amazonaws.com/AWSReservedSSO_CompassoSuporte_*",
            "arn:aws:iam::*:role/aws-reserved/sso.amazonaws.com/AWSReservedSSO_CompassoCloudTeam_*",
            "arn:aws:iam::*:role/aws-reserved/sso.amazonaws.com/AWSReservedSSO_CompassoAdmins_*",
            "arn:aws:iam::*:role/aws-reserved/sso.amazonaws.com/AWSReservedSSO_CompassoNetwork_*",
            "arn:aws:iam::*:role/CrossAccountAdmin"
          ]
        }
      }
    }
  ]
}
CONTENT
}


# SCPCompassoUOL-ProtectAWSSSO

resource "aws_organizations_policy" "policy_ProtectAWSSSO" {
  name        = "SCPCompassoUOL-ProtectAWSSSO"
  description = "SCP Compasso UOL - Protect Settings on AWS SSO"
  tags        = var.registro_polices

  content = <<CONTENT
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "ProtectSSO",
      "Effect": "Deny",
      "Action": [
        "sso:*",
        "sso-directory:*"
      ],
      "Resource": "*",
      "Condition": {
        "ArnNotLike": {
          "aws:PrincipalArn": [
            "arn:aws:iam::*:role/aws-reserved/sso.amazonaws.com/AWSReservedSSO_CompassoCloudTeam_*",
            "arn:aws:iam::*:role/aws-reserved/sso.amazonaws.com/AWSReservedSSO_CompassoAdmins_*"
          ]
        }
      }
    }
  ]
}
CONTENT
}


# SCPCompassoUOL-Recommended

resource "aws_organizations_policy" "policy_compassouol_recommended" {
  name        = "SCPCompassoUOL-Recommended"
  description = "SCP Compasso UOL - Package Recommended Service Control Policy"
  tags        = var.registro_polices

  content = <<CONTENT
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "DenyRootAccount",
      "Effect": "Deny",
      "NotAction": [
        "support:*",
        "iam:ListMFADevices",
        "iam:ListAccountAliases",
        "iam:GetAccountSummary",
        "iam:GetAccountPasswordPolicy",
        "iam:EnableMFADevice",
        "iam:CreateVirtualMFADevice",
        "iam:ChangePassword",
        "aws-portal:ViewAccount",
        "aws-portal:ModifyAccount"
      ],
      "Resource": "*",
      "Condition": {
        "StringLike": {
          "aws:PrincipalArn": "arn:aws:iam::*:root"
        }
      }
    },
    {
      "Sid": "ProtectS3CompassoTFState",
      "Effect": "Deny",
      "Action": [
        "s3:DeleteObjectVersion",
        "s3:DeleteObject",
        "s3:DeleteBucket"
      ],
      "Resource": "arn:aws:s3:::s3-compasso-uol-tfstate",
      "Condition": {
        "ArnNotLike": {
          "aws:PrincipalArn": [
            "arn:aws:iam::*:role/aws-reserved/sso.amazonaws.com/AWSReservedSSO_CompassoAdmins_*",
            "arn:aws:iam::*:role/CrossAccountAdmin"
          ]
        }
      }
    },
    {
      "Sid": "ProtectAssumeRole",
      "Effect": "Deny",
      "Action": "*",
      "Resource": [
        "arn:aws:iam::*:role/aws-reserved/sso.amazonaws.com/AWSReservedSSO_CompassoAdmins*",
        "arn:aws:iam::*:role/CrossAccountSupportNetwork",
        "arn:aws:iam::*:role/CrossAccountSignin",
        "arn:aws:iam::*:role/CrossAccountLambdaBilling",
        "arn:aws:iam::*:role/CrossAccountAdmin",
        "arn:aws:iam::*:role/uoldiveo-mgmt-cost"
      ],
      "Condition": {
        "ArnNotLike": {
          "aws:PrincipalArn": [
            "arn:aws:iam::*:role/aws-reserved/sso.amazonaws.com/AWSReservedSSO_CompassoAdmins_*",
            "arn:aws:iam::*:role/CrossAccountAdmin",
            "arn:aws:iam::*:role/uoldiveo-mgmt-cost"
          ]
        }
      }
    },
    {
      "Sid": "PreventLeaveOrganizations",
      "Effect": "Deny",
      "Action": "organizations:LeaveOrganization",
      "Resource": "*",
      "Condition": {
        "ArnNotLike": {
          "aws:PrincipalArn": [
            "arn:aws:iam::*:role/aws-reserved/sso.amazonaws.com/AWSReservedSSO_CompassoAdmins_*",
            "arn:aws:iam::*:role/CrossAccountAdmin"
          ]
        }
      }
    }
  ]
}
CONTENT
}