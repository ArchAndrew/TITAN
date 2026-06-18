resource "aws_config_conformance_pack" "this" {
  name          = var.conformance_pack_name
  template_body = var.template_body
}