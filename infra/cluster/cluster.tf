module "ecs_cluster" {
  source = "infrablocks/ecs-cluster/aws"
  version = "3.4.0"

  region = var.region

  component = var.component
  deployment_identifier = var.deployment_identifier

  vpc_id = data.terraform_remote_state.tooling_network.outputs.vpc_id
  subnet_ids = data.terraform_remote_state.tooling_network.outputs.private_subnet_ids
  allowed_cidrs = [var.private_network_cidr]

  cluster_instance_type = var.cluster_instance_type

  cluster_minimum_size = 3
  cluster_maximum_size = 4
  cluster_desired_capacity = 3

  cluster_instance_user_data_template = file("${path.root}/scripts/user-data.tpl")
  cluster_instance_iam_policy_contents = file("${path.root}/policies/cluster-instance-policy.json")

  cluster_instance_root_block_device_size = 1000
  cluster_instance_root_block_device_type = "gp2"
}
