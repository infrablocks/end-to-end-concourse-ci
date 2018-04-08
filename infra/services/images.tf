data "template_file" "web_image" {
  template = "$${repository_url}:$${tag}"

  vars {
    repository_url = "${data.terraform_remote_state.web_image_repository.repository_url}"
    tag = "${var.version_number}"
  }
}

data "template_file" "worker_image" {
  template = "$${repository_url}:$${tag}"

  vars {
    repository_url = "${data.terraform_remote_state.worker_image_repository.repository_url}"
    tag = "${var.version_number}"
  }
}