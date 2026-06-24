include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../../../terraform/modules/eks"
}

dependency "vpc" {
  config_path = "../vpc"
}

inputs = {
  cluster_name = "titan-dev"

  subnet_ids = dependency.vpc.outputs.private_subnet_ids

  node_instance_types = ["t3.small"]

  desired_size = 2
  min_size     = 1
  max_size     = 3

  tags = {
    Project          = "TITAN"
    Environment      = "dev"
    Application      = "eks"
    BusinessOwner    = "platform-engineering"
    TechnicalOwner   = "cloud-platform"
    ComplianceScope  = "nist-800-53"
    ManagedBy        = "terragrunt"
  }
}