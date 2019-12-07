data "aws_acm_certificate" "wildcard" {
  domain = data.terraform_remote_state.domain.domain_name
}
