resource "aws_kms_key" "gov_vault_key" {
  description             = "KMS Key for Government Data Vault Encryption"
  deletion_window_in_days = 30
  enable_key_rotation     = true

  tags = {
    Environment = "GovTech-Production"
    Compliance  = "High-Security"
    ManagedBy   = "devops-admin"
  }
}

resource "aws_kms_alias" "gov_vault_alias" {
  name          = "alias/govtech-vault-kms-key"
  target_key_id = aws_kms_key.gov_vault_key.key_id
}