# AWS Backup Vault
resource "aws_backup_vault" "gov_dr_vault" {
  name        = "govtech_dr_recovery_vault"
  kms_key_arn = aws_kms_key.gov_vault_key.arn
}

# AWS Backup Plan
resource "aws_backup_plan" "gov_backup_plan" {
  name = "govtech_daily_dr_plan"

  rule {
    rule_name         = "daily_backup_rule"
    target_vault_name = aws_backup_vault.gov_dr_vault.name
    schedule          = "cron(0 12 * * ? *)"

    lifecycle {
      delete_after = 30
    }
  }
}