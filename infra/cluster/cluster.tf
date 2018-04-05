data "template_file" "cluster_instance_user_data_template" {
  template = "${file("${path.root}/scripts/user-data.tpl")}"
}

module "ecs_cluster" {
  source = "infrablocks/ecs-cluster/aws"
  version = "0.2.7-rc.2"

  region = "${var.region}"
  vpc_id = "${data.terraform_remote_state.tooling_network.vpc_id}"
  subnet_ids = "${data.terraform_remote_state.tooling_network.private_subnet_ids}"
  allowed_cidrs = ["${var.private_network_cidr}"]

  component = "${var.component}"
  deployment_identifier = "${var.deployment_identifier}"

  cluster_instance_ssh_public_key_path = "${var.cluster_instance_ssh_public_key_path}"
  cluster_instance_type = "${var.cluster_instance_type}"

  cluster_minimum_size = 3
  cluster_maximum_size = 4
  cluster_desired_capacity = 3

  cluster_instance_user_data_template = "${data.template_file.cluster_instance_user_data_template.rendered}"
  cluster_instance_iam_policy_contents = "${file("${path.root}/policies/cluster-instance-policy.json")}"

  cluster_instance_root_block_device_size = 100
  cluster_instance_docker_block_device_size = 30

  cluster_instance_amis = {
    us-east-1 = "ami-9eb4b1e5"
    us-east-2 = "ami-1c002379"
    us-west-1 = "ami-4a2c192a"
    us-west-2 = "ami-1d668865"
    eu-west-1 = "ami-8fcc32f6"
    eu-west-2 = "ami-cb1101af"
    eu-central-1 = "ami-0460cb6b"
    ap-northeast-1 = "ami-b743bed1"
    ap-southeast-1 = "ami-9d1f7efe"
    ap-southeast-2 = "ami-c1a6bda2"
    ca-central-1 = "ami-b677c9d2"
  }
}
