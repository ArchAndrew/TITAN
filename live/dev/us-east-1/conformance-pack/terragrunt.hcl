include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../../../terraform/modules/conformance-pack"
}

dependencies {
  paths = [
    "../aws-config"
  ]
}

inputs = {
  conformance_pack_name = "titan-security-baseline"

  template_body = file("../../../../terraform/modules/conformance-pack/titan-security-baseline.yaml")
}