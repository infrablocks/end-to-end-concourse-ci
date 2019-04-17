module "state_bucket" {
  source = "infrablocks/encrypted-bucket/aws"
  version = "0.2.0"

  bucket_name = "${var.state_bucket_name}"

  tags = {
    DeploymentIdentifier = "${var.deployment_identifier}"
  }
}
