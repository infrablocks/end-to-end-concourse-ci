data "terraform_remote_state" "web_image_repository" {
  backend = "s3"

  config = {
    bucket = var.web_image_repository_state_bucket_name
    key = var.web_image_repository_state_key
    region = var.web_image_repository_state_bucket_region
    encrypt = var.web_image_repository_state_bucket_is_encrypted
  }
}

data "terraform_remote_state" "worker_image_repository" {
  backend = "s3"

  config = {
    bucket = var.worker_image_repository_state_bucket_name
    key = var.worker_image_repository_state_key
    region = var.worker_image_repository_state_bucket_region
    encrypt = var.worker_image_repository_state_bucket_is_encrypted
  }
}
