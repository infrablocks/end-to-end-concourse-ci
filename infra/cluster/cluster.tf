data "template_file" "cluster_instance_user_data_template" {
  template = "${file("${path.root}/scripts/user-data.tpl")}"
}

module "ecs_cluster" {
  source = "infrablocks/ecs-cluster/aws"
  version = "0.6.0"

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
    us-east-1 = "ami-cb17d8b6"
    us-east-2 = "ami-1b90a67e"
    us-west-1 = "ami-9cbbaffc"
    us-west-2 = "ami-05b5277d"
    eu-west-1 = "ami-bfb5fec6"
    eu-west-2 = "ami-a48d6bc3"
    eu-west-3 = "ami-914afcec"
    eu-central-1 = "ami-ac055447"
    ap-northeast-1 = "ami-5add893c"
    ap-northeast-2 = "ami-ba74d8d4"
    ap-southeast-1 = "ami-acbcefd0"
    ap-southeast-2 = "ami-4cc5072e"
    ca-central-1 = "ami-a535b2c1"
    ap-south-1 = "ami-2149114e"
    sa-east-1 = "ami-d3bce9bf"
  }
}
