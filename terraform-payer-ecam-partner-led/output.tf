## -------- outputs
output "brand_new_user_id" {
  value = aws_iam_access_key.brand_new_user.id
}

data "template_file" "secret" {
  template = aws_iam_access_key.brand_new_user.secret
}

output "brand_new_user_secret" {
  value = data.template_file.secret.rendered
}

output "s3_bucket_cloudtrail" {
  value = aws_s3_bucket.enable_cloudtrail.0.id
}