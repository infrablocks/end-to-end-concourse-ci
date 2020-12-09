data "aws_acm_certificate" "wildcard" {
  domain = "*.${data.terraform_remote_state.domain.outputs.domain_name}"
  most_recent = true
}
