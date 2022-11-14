resource "aws_cur_report_definition" "report_payer" {
  report_name                = "Billing-CUR"
  time_unit                  = "HOURLY"
  format                     = "textORcsv"
  compression                = "GZIP"
  additional_schema_elements = ["RESOURCES"]
  s3_bucket                  = "example-bucket-name"
  s3_region                  = "us-east-1"
  #additional_artifacts       = ["REDSHIFT", "QUICKSIGHT"]
}

#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cur_report_definition