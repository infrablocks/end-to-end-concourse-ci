data "terraform_remote_state" "database" {
  backend = "s3"

  config {
    region = "${var.database_state_bucket_region}"
    bucket = "${var.database_state_bucket_name}"
    encrypt = "${var.database_state_bucket_is_encrypted}"
    key = "${var.database_state_key}"
  }
}
