resource "aws_config_config_rule" "s3_bucket_public_read_prohibited" {
  name = "titan-s3-bucket-public-read-prohibited"

  source {
    owner             = "AWS"
    source_identifier = "S3_BUCKET_PUBLIC_READ_PROHIBITED"
  }

  tags = var.tags
}

resource "aws_config_config_rule" "s3_bucket_public_write_prohibited" {
  name = "titan-s3-bucket-public-write-prohibited"

  source {
    owner             = "AWS"
    source_identifier = "S3_BUCKET_PUBLIC_WRITE_PROHIBITED"
  }

  tags = var.tags
}

resource "aws_config_config_rule" "encrypted_volumes" {
  name = "titan-encrypted-volumes"

  source {
    owner             = "AWS"
    source_identifier = "ENCRYPTED_VOLUMES"
  }

  tags = var.tags
}

resource "aws_config_config_rule" "root_account_mfa_enabled" {
  name = "titan-root-account-mfa-enabled"

  source {
    owner             = "AWS"
    source_identifier = "ROOT_ACCOUNT_MFA_ENABLED"
  }

  tags = var.tags
}

resource "aws_config_config_rule" "cloudtrail_enabled" {
  name = "titan-cloudtrail-enabled"

  source {
    owner             = "AWS"
    source_identifier = "CLOUD_TRAIL_ENABLED"
  }

  tags = var.tags
}

resource "aws_config_config_rule" "iam_password_policy" {
  name = "titan-iam-password-policy"

  source {
    owner             = "AWS"
    source_identifier = "IAM_PASSWORD_POLICY"
  }

  tags = var.tags
}