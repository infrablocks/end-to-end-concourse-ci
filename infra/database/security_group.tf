resource "aws_security_group" "database" {
  name = "security-group-${var.component}-${var.deployment_identifier}"
  description = "Allow access to Concourse PostgreSQL from private network."
  vpc_id = data.terraform_remote_state.network.outputs.vpc_id

  tags = {
    Name = "sg-${var.component}-${var.deployment_identifier}"
    Component = var.component
    DeploymentIdentifier = var.deployment_identifier
  }

  ingress {
    from_port = 5432
    to_port = 5432
    protocol = "tcp"
    cidr_blocks = [
      var.private_network_cidr
    ]
  }
}