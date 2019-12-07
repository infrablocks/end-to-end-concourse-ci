module "state_bucket" {
  source = "infrablocks/encrypted-bucket/aws"
  version = "1.0.0"

  bucket_name = var.state_bucket_name

  tags = {
    DeploymentIdentifier = var.deployment_identifier
  }
}
