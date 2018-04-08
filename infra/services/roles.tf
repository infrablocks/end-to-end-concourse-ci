data "aws_iam_policy_document" "provisioning_assume_role_policy_contents" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      identifiers = ["${data.terraform_remote_state.cluster.ecs_cluster_instance_role_arn}"]
      type = "AWS"
    }

    effect = "Allow"
  }
}

data "aws_iam_policy_document" "provisioning_role_policy_contents" {
  statement {
    actions = [
      "ec2:*",
      "ecs:*",
      "ecr:*",
      "autoscaling:*",
      "elasticloadbalancing:*",
      "s3:*",
      "rds:*",
      "sns:*",
      "iam:*",
      "route53:*",
      "acm:*",
      "lambda:*",
      "logs:*",
      "events:*",
      "cloudfront:*",
      "cloudtrail:*",
      "cloudwatch:*",
    ]

    resources = [
      "*",
    ]
  }
}

resource "aws_iam_role" "provisioning_role" {
  name = "provisioning-role-${var.component}-${var.deployment_identifier}"

  assume_role_policy = "${data.aws_iam_policy_document.provisioning_assume_role_policy_contents.json}"
}

resource "aws_iam_role_policy" "provisioning_role_policy" {
  role = "${aws_iam_role.provisioning_role.id}"
  policy = "${data.aws_iam_policy_document.provisioning_role_policy_contents.json}"
}

data "aws_iam_policy_document" "ci_limited" {
  statement {
    actions = [
      "s3:*"
    ]
    resources = [
      "*"
    ]
  }

  statement {
    effect = "Deny"
    actions = [
      "s3:DeleteBucket",
      "s3:DeleteBucketPolicy",
      "s3:DeleteBucketWebsite",
      "s3:ListAllMyBuckets",
      "s3:PutBucketAcl",
      "s3:PutBucketCORS",
      "s3:PutBucketPolicy",
      "s3:PutBucketVersioning",
      "s3:PutBucketWebsite",
      "s3:PutBucketLogging",
      "s3:PutBucketNotification",
      "s3:PutBucketRequestPayment",
      "s3:PutBucketTagging",
      "s3:PutLifecycleConfiguration",
      "s3:PutReplicationConfiguration",
      "s3:PutAccelerateConfiguration",
      "s3:ReplicateDelete",
      "s3:ReplicateObject"
    ]
    resources = [
      "*",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "ecr:GetAuthorizationToken",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchCheckLayerAvailability",
      "ecr:BatchGetImage",
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:PutImage",
      "ecr:CompleteLayerUpload"
    ]

    resources = ["*"]
  }
}

resource "aws_iam_user" "ci_limited" {
  name = "ci-limited"
  path = "/infra/"
}

resource "aws_iam_user_policy" "ci_limited" {
  name = "ci-limited"
  user = "${aws_iam_user.ci_limited.name}"
  policy = "${data.aws_iam_policy_document.ci_limited.json}"
}

resource "aws_iam_access_key" "ci_limited" {
  user = "${aws_iam_user.ci_limited.name}"
  pgp_key = "${file(var.ci_gpg_public_key_path)}"
}
