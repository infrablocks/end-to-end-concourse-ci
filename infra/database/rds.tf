module "database" {
  source  = "infrablocks/rds-postgres/aws"
  version = "1.5.0"

  component = var.component
  deployment_identifier = var.deployment_identifier

  database_name = var.database_name
  database_master_user = var.database_username
  database_master_user_password = var.database_password

  vpc_id = data.terraform_remote_state.network.outputs.vpc_id
  private_subnet_ids = data.terraform_remote_state.network.outputs.private_subnet_ids
  private_network_cidr = var.private_network_cidr

  database_version = "11.9"
  database_instance_class = "db.t2.large"

  use_encrypted_storage = "yes"
  use_multiple_availability_zones = "yes"
}
