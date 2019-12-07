data "terraform_remote_state" "domain" {
  backend = "s3"

  config = {
    region = var.domain_state_bucket_region
    bucket = var.domain_state_bucket_name
    encrypt = var.domain_state_bucket_is_encrypted
    key = var.domain_state_key
  }
}
