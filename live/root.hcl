locals {

  account_vars = read_terragrunt_config("${get_parent_terragrunt_dir()}/_global/account.hcl")
  region_vars  = read_terragrunt_config("${get_parent_terragrunt_dir()}/_global/region.hcl")
  env_vars     = read_terragrunt_config(find_in_parent_folders("env.hcl"))

  aws_account_id = local.account_vars.locals.aws_account_id
  aws_region     = local.region_vars.locals.aws_region
  environment    = local.env_vars.locals.environment
  project_name   = "titan"
}

remote_state {
  backend = "s3"

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }

  config = {
    bucket       = "titan-tf-state-archandrew-us-east-1"
    key          = "${path_relative_to_include()}/terraform.tfstate"
    region       = local.aws_region
    encrypt      = true
    use_lockfile = true
  }
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"

  contents = <<EOF
provider "aws" {
  region = "${local.aws_region}"

  default_tags {
    tags = {
      Project     = "TITAN"
      Environment = "${local.environment}"
      ManagedBy   = "Terragrunt"
    }
  }
}
EOF
}