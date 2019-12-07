resource "aws_db_instance" "database" {
  identifier = "db-instance-${var.component}-${var.deployment_identifier}"

  allocated_storage = 10

  engine = "postgres"
  engine_version = "9.5.10"

  instance_class = "db.t2.large"

  name = var.database_name
  username = var.database_username
  password = var.database_password

  publicly_accessible = false
  multi_az = false
  storage_encrypted = false

  db_subnet_group_name = aws_db_subnet_group.database.name

  vpc_security_group_ids = [
    aws_security_group.database.id
  ]

  tags = {
    Name = "db-instance-${var.component}-${var.deployment_identifier}"
    Component = var.component
    DeploymentIdentifier = var.deployment_identifier
  }
}

resource "aws_db_subnet_group" "database" {
  name = "${var.component}-${var.deployment_identifier}"
  description = "Subnet group for Concourse PostgreSQL instance."
  subnet_ids = split(",", data.terraform_remote_state.network.outputs.private_subnet_ids)

  tags = {
    Name = "db-subnet-group-${var.component}-${var.deployment_identifier}"
    Component = var.component
    DeploymentIdentifier = var.deployment_identifier
  }
}
