output "concourse_database_address" {
  value = "${aws_db_instance.database.address}"
}