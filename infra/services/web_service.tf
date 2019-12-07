data "template_file" "web_task_container_definitions" {
  template = file("${path.root}/container-definitions/web.json.tpl")

  vars = {
    environment_object_path = "s3://${var.secrets_bucket_name}/${data.template_file.web_environment_object_key.rendered}"
  }
}

data "aws_iam_policy_document" "web_assume_role_policy_content" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      identifiers = ["ecs-tasks.amazonaws.com"]
      type = "Service"
    }

    effect = "Allow"
  }
}

data "aws_iam_policy_document" "web_role_policy_content" {
  statement {
    actions = [
      "s3:GetObject",
    ]

    resources = [
      "arn:aws:s3:::${var.secrets_bucket_name}/*",
    ]
  }
}

resource "aws_iam_role" "web_role" {
  name = "concourse-web-role-${var.component}-${var.deployment_identifier}"

  assume_role_policy = data.aws_iam_policy_document.web_assume_role_policy_content.json
}

resource "aws_iam_role_policy" "web_role_policy" {
  role = aws_iam_role.web_role.id
  policy = data.aws_iam_policy_document.web_role_policy_content.json
}

module "ecs_service" {
  source = "infrablocks/ecs-service/aws"
  version = "1.0.0"

  region = var.region
  vpc_id = data.terraform_remote_state.network.outputs.vpc_id

  component = var.component
  deployment_identifier = var.deployment_identifier

  service_name = "concourse-web"
  service_image = data.template_file.web_image.rendered
  service_port = var.http_port

  service_task_container_definitions = data.template_file.web_task_container_definitions.rendered
  service_task_network_mode = "host"

  service_desired_count = var.web_desired_count
  service_deployment_minimum_healthy_percent = "50"
  service_deployment_maximum_percent = "200"

  service_elb_name = aws_elb.service_load_balancer.name
  service_role = aws_iam_role.web_role.arn

  ecs_cluster_id = data.terraform_remote_state.cluster.outputs.ecs_cluster_id
  ecs_cluster_service_role_arn = data.terraform_remote_state.cluster.outputs.ecs_service_role_arn
}
