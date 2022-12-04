resource "aws_cur_report_definition" "report_payer" {

  #depends_on = [aws_s3_bucket.usage_report]

  report_name                = "Billing-CUR"
  time_unit                  = "HOURLY"
  format                     = "textORcsv"
  compression                = "GZIP"
  additional_schema_elements = ["RESOURCES"]
  s3_bucket                  = var.s3_name
  s3_prefix                  = "${data.aws_caller_identity.current.account_id}-aws-billing-cur/Billing-CUR"
  s3_region                  = "us-east-1"
  #additional_artifacts       = ["REDSHIFT", "QUICKSIGHT"]
}


#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cur_report_definition

variable "s3_name" {
  type    = string
  default = "cloudhealth-bucket-test-mais"
}

data "aws_caller_identity" "current" {}



resource "aws_s3_bucket" "usage_report" {
  bucket        = var.s3_name
  force_destroy = true

  tags = {
    Name        = "Bucket-CUR"
    Environment = "Payer"
  }
}

resource "aws_s3_bucket_logging" "my_logging" {
  bucket = aws_s3_bucket.usage_report.id

  target_bucket = aws_s3_bucket.usage_report.id
  target_prefix = "${data.aws_caller_identity.current.account_id}-aws-billing-cur/Billing-CUR"
}

resource "aws_s3_bucket_acl" "bucket_usage_acl" {
  bucket = aws_s3_bucket.usage_report.id
  acl    = "private"
}

resource "aws_s3_bucket_policy" "usage_policy" {
  bucket = aws_s3_bucket.usage_report.id
  policy = data.aws_iam_policy_document.policy_doc.json
}


data "aws_iam_policy_document" "policy_doc" {

  statement {
    sid    = "AWSUsageReport"
    effect = "Allow"
    actions = [
      "s3:GetBucketAcl",
      "s3:GetBucketPolicy"
    ]
    principals {
      type        = "Service"
      identifiers = ["billingreports.amazonaws.com"]
    }
    resources = [
      "${aws_s3_bucket.usage_report.arn}"
    ]
    condition {
      test     = "StringEquals"
      variable = "aws:SourceAccount"
      values   = ["${data.aws_caller_identity.current.account_id}"]
    }
    condition {
      test     = "StringEquals"
      variable = "aws:SourceArn"
      values   = ["arn:aws:cur:us-east-1:${data.aws_caller_identity.current.account_id}:definition/*"]
    }
  }
  statement {
    sid    = "AWSCloudObject"
    effect = "Allow"
    actions = [
      "s3:PutObject"
    ]
    principals {
      type        = "Service"
      identifiers = ["billingreports.amazonaws.com"]
    }
    resources = [
      "${aws_s3_bucket.usage_report.arn}/*",
    ]
    condition {
      test     = "StringEquals"
      variable = "aws:SourceAccount"
      values   = ["${data.aws_caller_identity.current.account_id}"]
    }
    condition {
      test     = "StringEquals"
      variable = "aws:SourceArn"
      values   = ["arn:aws:cur:us-east-1:${data.aws_caller_identity.current.account_id}:definition/*"]
    }
  }
}


#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy