data "template_file" "web_url" {
  template = "$${component}-$${deployment_identifier}.$${domain_name}"

  vars {
    component = "${var.component}"
    deployment_identifier = "${var.deployment_identifier}"
    domain_name = "${data.terraform_remote_state.domain.domain_name}"
  }
}

data "template_file" "oauth_url" {
  template = "$${component}-$${deployment_identifier}.$${domain_name}"

  vars {
    component = "${var.component}"
    deployment_identifier = "${var.deployment_identifier}"
    domain_name = "${data.terraform_remote_state.domain.domain_name}"
  }
}

data "template_file" "web_env" {
  template = "${file("${path.root}/envfiles/web.env.tpl")}"

  vars {
    http_basic_username="${var.http_basic_username}"
    http_basic_password="${var.http_basic_password}"

    github_oauth_client_id = "${var.github_oauth_client_id}"
    github_oauth_client_secret = "${var.github_oauth_client_secret}"
    github_organization = "${var.github_organization}"

    database_host = "${data.terraform_remote_state.database.concourse_database_address}"
    database_username = "${var.database_username}"
    database_password = "${var.database_password}"
    database_name = "${var.database_name}"
    external_url = "https://${data.template_file.web_url.rendered}"
    oauth_base_url = "https://${data.template_file.oauth_url.rendered}"

    secrets_bucket = "${var.secrets_bucket_name}"

    session_signing_private_key_key = "${data.template_file.session_signing_private_key_key.rendered}"
    tsa_host_private_key_key = "${data.template_file.tsa_host_private_key_key.rendered}"
    authorized_worker_keys_key = "${data.template_file.authorized_worker_keys_key.rendered}"
  }
}

data "template_file" "web_environment_object_key" {
  template = "secrets/environments/web.env"
}

data "template_file" "worker_environment_object_key" {
  template = "secrets/environments/worker.env"
}

data "template_file" "session_signing_private_key_key" {
  template = "secrets/keys/session_signing_key.private"
}

data "template_file" "tsa_host_public_key_key" {
  template = "secrets/keys/tsa_host_key.public"
}

data "template_file" "tsa_host_private_key_key" {
  template = "secrets/keys/tsa_host_key.private"
}

data "template_file" "worker_private_key_key" {
  template = "secrets/keys/worker_key.private"
}

data "template_file" "authorized_worker_keys_key" {
  template = "secrets/keys/authorized_worker_keys"
}

resource "aws_s3_bucket_object" "web_env" {
  key = "${data.template_file.web_environment_object_key.rendered}"
  bucket = "${var.secrets_bucket_name}"
  content = "${data.template_file.web_env.rendered}"

  server_side_encryption = "AES256"
}

data "template_file" "worker_env" {
  template = "${file("${path.root}/envfiles/worker.env.tpl")}"

  vars {
    tsa_host = "${data.template_file.web_url.rendered}"
    ssh_port = "${var.ssh_port}"

    secrets_bucket = "${var.secrets_bucket_name}"

    tsa_host_public_key_key = "${data.template_file.tsa_host_public_key_key.rendered}"
    worker_private_key_key = "${data.template_file.worker_private_key_key.rendered}"
  }
}
resource "aws_s3_bucket_object" "worker_env" {
  key = "secrets/environments/worker.env"
  bucket = "${var.secrets_bucket_name}"
  content = "${data.template_file.worker_env.rendered}"

  server_side_encryption = "AES256"
}

resource "aws_s3_bucket_object" "session_signing_key_private" {
  key = "${data.template_file.session_signing_private_key_key.rendered}"
  bucket = "${var.secrets_bucket_name}"
  source = "../../../config/secrets/concourse/keys/session_signing_key.private"

  server_side_encryption = "AES256"
}

resource "aws_s3_bucket_object" "tsa_host_private_key" {
  key = "${data.template_file.tsa_host_private_key_key.rendered}"
  bucket = "${var.secrets_bucket_name}"
  source = "../../../config/secrets/concourse/keys/tsa_host_key.private"

  server_side_encryption = "AES256"
}

resource "aws_s3_bucket_object" "tsa_host_public_key" {
  key = "${data.template_file.tsa_host_public_key_key.rendered}"
  bucket = "${var.secrets_bucket_name}"
  source = "../../../config/secrets/concourse/keys/tsa_host_key.public"

  server_side_encryption = "AES256"
}

resource "aws_s3_bucket_object" "worker_private_key" {
  key = "${data.template_file.worker_private_key_key.rendered}"
  bucket = "${var.secrets_bucket_name}"
  source = "../../../config/secrets/concourse/keys/worker_key.private"

  server_side_encryption = "AES256"
}

resource "aws_s3_bucket_object" "authorized_worker_keys" {
  key = "${data.template_file.authorized_worker_keys_key.rendered}"
  bucket = "${var.secrets_bucket_name}"
  source = "../../../config/secrets/concourse/keys/authorized_worker_keys"

  server_side_encryption = "AES256"
}
