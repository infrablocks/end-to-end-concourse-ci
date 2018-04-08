data "terraform_remote_state" "cluster" {
  backend = "s3"

  config {
    region = "${var.cluster_state_bucket_region}"
    bucket = "${var.cluster_state_bucket_name}"
    encrypt = "${var.cluster_state_bucket_is_encrypted}"
    key = "${var.cluster_state_key}"
  }
}
