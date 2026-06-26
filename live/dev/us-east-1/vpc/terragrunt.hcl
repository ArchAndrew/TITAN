include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../../../terraform/modules/vpc"
}

inputs = {
  name       = "titan-dev-vpc"
  cidr_block = "10.40.0.0/16"

  azs = [
    "us-east-1a",
    "us-east-1b",
    "us-east-1c"
  ]

  public_subnet_cidrs = [
    "10.40.1.0/24",
    "10.40.2.0/24",
    "10.40.3.0/24"
  ]

  private_subnet_cidrs = [
    "10.40.11.0/24",
    "10.40.12.0/24",
    "10.40.13.0/24"
  ]

  tags = {
    Project         = "TITAN"
    Environment     = "dev"
    Application     = "vpc"
    BusinessOwner   = "platform-engineering"
    TechnicalOwner  = "cloud-platform"
    ComplianceScope = "nist-800-53"
    ManagedBy       = "terragrunt"
  }
}