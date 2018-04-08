output "ci_s3_user_access_key_id" {
  value = "${aws_iam_access_key.ci_limited.id}"
}

output "ci_s3_user_encrypted_secret_access_key" {
  value = "${aws_iam_access_key.ci_limited.encrypted_secret}"
}
