data "terraform_remote_state" "network" {
  backend = "s3"

  config = {
    region = var.network_state_bucket_region
    bucket = var.network_state_bucket_name
    key = var.network_state_key
    encrypt = var.network_state_bucket_is_encrypted
  }
}
