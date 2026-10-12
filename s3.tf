# Main Citizen Data Vault Bucket
resource "aws_s3_bucket" "gov_vault" {
  bucket        = "citizen-records-vault-sec-2026"
  force_destroy = true
}

# Block ALL Public Access (Zero-Trust Security)
resource "aws_s3_bucket_public_access_block" "gov_vault_privacy" {
  bucket                  = aws_s3_bucket.gov_vault.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# KMS Server-Side Encryption Setup
resource "aws_s3_bucket_server_side_encryption_configuration" "gov_vault_encryption" {
  bucket = aws_s3_bucket.gov_vault.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.gov_vault_key.arn
      sse_algorithm     = "aws:kms"
    }
  }
}

# Enable Versioning for Disaster Recovery
resource "aws_s3_bucket_versioning" "gov_vault_versioning" {
  bucket = aws_s3_bucket.gov_vault.id
  versioning_configuration {
    status = "Enabled"
  }
}