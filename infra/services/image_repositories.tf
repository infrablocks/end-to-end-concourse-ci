data "terraform_remote_state" "web_image_repository" {
  backend = "s3"

  config = {
    region = var.web_image_repository_state_bucket_region
    bucket = var.web_image_repository_state_bucket_name
    encrypt = var.web_image_repository_state_bucket_is_encrypted
    key = var.web_image_repository_state_key
  }
}

data "terraform_remote_state" "worker_image_repository" {
  backend = "s3"

  config = {
    region = var.worker_image_repository_state_bucket_region
    bucket = var.worker_image_repository_state_bucket_name
    encrypt = var.worker_image_repository_state_bucket_is_encrypted
    key = var.worker_image_repository_state_key
  }
}
