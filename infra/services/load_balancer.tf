resource "aws_elb" "service_load_balancer" {
  subnets = ["${split(",", data.terraform_remote_state.network.public_subnet_ids)}"]

  security_groups = [
    "${aws_security_group.private_elb_security_group.id}"
  ]

  listener {
    instance_port = "${var.http_port}"
    instance_protocol = "tcp"
    lb_port = 443
    lb_protocol = "ssl"
    ssl_certificate_id = "${data.aws_acm_certificate.wildcard.arn}"
  }

  listener {
    instance_port = "${var.ssh_port}"
    instance_protocol = "tcp"
    lb_port = "${var.ssh_port}"
    lb_protocol = "tcp"
  }

  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    target = "TCP:${var.http_port}"
    interval = 30
  }

  cross_zone_load_balancing = true
  idle_timeout = 60
  connection_draining = true
  connection_draining_timeout = 60

  tags {
    Name = "elb-${var.component}-${var.deployment_identifier}"
    Component = "${var.component}"
    DevelopmentIdentifier = "${var.deployment_identifier}"
    Service = "web"
  }
}

resource "aws_route53_record" "public_dns_record" {
  zone_id = "${data.terraform_remote_state.domain.public_zone_id}"
  name = "${var.component}-${var.deployment_identifier}.${data.terraform_remote_state.domain.domain_name}"
  type = "A"

  alias {
    name = "${aws_elb.service_load_balancer.dns_name}"
    zone_id = "${aws_elb.service_load_balancer.zone_id}"
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "private_dns_record" {
  zone_id = "${data.terraform_remote_state.domain.private_zone_id}"
  name = "${var.component}-${var.deployment_identifier}.${data.terraform_remote_state.domain.domain_name}"
  type = "A"

  alias {
    name = "${aws_elb.service_load_balancer.dns_name}"
    zone_id = "${aws_elb.service_load_balancer.zone_id}"
    evaluate_target_health = false
  }
}

resource "aws_security_group" "private_elb_security_group" {
  name = "private-elb-${var.component}-${var.deployment_identifier}"
  vpc_id = "${data.terraform_remote_state.network.vpc_id}"
  description = "${var.component}-elb"

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0",
      "${var.private_network_cidr}"
    ]
  }

  ingress {
    from_port = "${var.ssh_port}"
    to_port = "${var.ssh_port}"
    protocol = "tcp"
    cidr_blocks = [
      "${data.terraform_remote_state.network.nat_public_ip}/32",
      "${var.private_network_cidr}"
    ]
  }

  egress {
    from_port = 1
    to_port   = 65535
    protocol  = "tcp"
    cidr_blocks = [
      "${var.private_network_cidr}"
    ]
  }
}
