resource "aws_vpc_endpoint" "private_s3" {
  vpc_id = module.base_network.vpc_id
  service_name = "com.amazonaws.${var.region}.s3"

  route_table_ids = [
    module.base_network.private_route_table_id
  ]
}
