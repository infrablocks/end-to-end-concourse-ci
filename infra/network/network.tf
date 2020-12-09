data "aws_availability_zones" "all" {}

module "base_network" {
  source = "infrablocks/base-networking/aws"
  version = "3.0.0"

  component = var.component
  deployment_identifier = var.deployment_identifier

  vpc_cidr = var.vpc_cidr
  region = var.region
  availability_zones = data.aws_availability_zones.all.names

  private_zone_id = data.terraform_remote_state.domain.outputs.private_zone_id
}
