output "registry_id" {
  value = "${aws_ecr_repository.image_repository.registry_id}"
}
output "repository_url" {
  value = "${aws_ecr_repository.image_repository.repository_url}"
}
