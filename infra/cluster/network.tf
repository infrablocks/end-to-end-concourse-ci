data "terraform_remote_state" "tooling_network" {
  backend = "s3"

  config = {
    region = var.network_state_bucket_region
    bucket = var.network_state_bucket_name
    encrypt = var.network_state_bucket_is_encrypted
    key = var.network_state_key
  }
}
