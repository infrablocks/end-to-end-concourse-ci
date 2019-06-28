resource "aws_cloudwatch_log_group" "service" {
  name = "/${var.component}/${var.deployment_identifier}/ecs-service/concourse-worker"

  tags = {
    DeploymentIdentifier = "${var.deployment_identifier}"
    Component = "${var.component}"
    Service = "concourse-worker"
  }
}

data "template_file" "worker_task_definition" {
  template = "${file("${path.root}/container-definitions/worker.json.tpl")}"

  vars = {
    name = "concourse-worker"
    image = "${data.template_file.worker_image.rendered}"
    region = "${var.region}"
    log_group = "${aws_cloudwatch_log_group.service.name}"
    environment_object_path = "s3://${var.secrets_bucket_name}/${data.template_file.worker_environment_object_key.rendered}"
  }
}

data "aws_iam_policy_document" "worker_assume_role_policy_contents" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      identifiers = ["ecs-tasks.amazonaws.com"]
      type = "Service"
    }

    effect = "Allow"
  }
}

data "aws_iam_policy_document" "worker_role_policy_contents" {
  statement {
    actions = [
      "s3:GetObject",
    ]

    resources = [
      "arn:aws:s3:::${var.secrets_bucket_name}/*",
    ]
  }
}

resource "aws_iam_role" "worker_role" {
  name = "concourse-worker-role-${var.component}-${var.deployment_identifier}"

  assume_role_policy = "${data.aws_iam_policy_document.worker_assume_role_policy_contents.json}"
}

resource "aws_iam_role_policy" "worker_role_policy" {
  role = "${aws_iam_role.worker_role.id}"
  policy = "${data.aws_iam_policy_document.worker_role_policy_contents.json}"
}

resource "aws_ecs_task_definition" "worker_task_definition" {
  family = "${var.component}-concourse-worker-${var.deployment_identifier}"
  container_definitions = "${data.template_file.worker_task_definition.rendered}"

  task_role_arn = "${aws_iam_role.worker_role.arn}"

  volume {
    name = "work-dir"
  }
}

resource "aws_ecs_service" "service" {
  name = "concourse-worker"
  cluster = "${data.terraform_remote_state.cluster.outputs.ecs_cluster_id}"
  task_definition = "${aws_ecs_task_definition.worker_task_definition.arn}"

  desired_count = "${var.worker_desired_count}"
  deployment_maximum_percent = 200
  deployment_minimum_healthy_percent = 50
}
