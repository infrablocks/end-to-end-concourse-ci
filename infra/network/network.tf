data "aws_availability_zones" "all" {}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners = ["amazon"]

  name_regex = "^amzn-ami-hvm-\\d{4}\\.\\d{2}\\.\\d*"

  filter {
    name = "name"
    values = ["amzn-ami-hvm-*-gp2"]
  }
}

module "base_network" {
  source = "infrablocks/base-networking/aws"
  version = "0.2.0-rc.2"

  component = "${var.component}"
  deployment_identifier = "${var.deployment_identifier}"

  vpc_cidr = "${var.vpc_cidr}"
  region = "${var.region}"
  availability_zones = "${join(",", data.aws_availability_zones.all.names)}"

  private_zone_id = "${data.terraform_remote_state.domain.private_zone_id}"
  include_lifecycle_events = "no"
}
