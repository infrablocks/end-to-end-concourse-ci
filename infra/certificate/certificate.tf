module "wildcard_certificate" {
  source  = "infrablocks/acm-certificate/aws"
  version = "0.8.0"

  domain_name = "*.${data.terraform_remote_state.domain.outputs.domain_name}"
  domain_zone_id = data.terraform_remote_state.domain.outputs.public_zone_id

  subject_alternative_names = []
  subject_alternative_name_zone_id = data.terraform_remote_state.domain.outputs.public_zone_id

  providers = {
    aws.certificate = aws
    aws.domain_validation = aws
    aws.san_validation = aws
  }
}
