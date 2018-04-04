resource "aws_ecr_repository" "image_repository" {
  name = "${var.repository_name}"
}