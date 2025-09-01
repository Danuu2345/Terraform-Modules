# This module now only provides backup infrastructure for existing EC2 instances
# The EC2 instance should be created separately (e.g. in Module-1) and passed to this module

# Attaches the managed policy AWSBackupServiceRolePolicyForBackup to the IAM role.
# This policy grants AWS Backup the necessary permissions to:
# - Start and manage backup jobs
# - Access EC2, RDS, EFS and other supported resources
# - Store recovery points in backup vaults

resource "aws_iam_role" "backup_role" {
  name = "aws-backup-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "backup.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "backup_policy" {
  role       = aws_iam_role.backup_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"
}

resource "aws_backup_vault" "vault" {
  name = var.backup_vault_name

  lifecycle {
    ignore_changes = [name]
  }
}

# AWS Backup Plan
resource "aws_backup_plan" "backup_plan" {
  name = var.backup_plan_name

  rule {
    rule_name         = "monthly-backup-rule"
    target_vault_name = aws_backup_vault.vault.name
    schedule          = var.backup_schedule

    lifecycle {
      delete_after = var.backup_retention_days
    }
  }
}

resource "aws_backup_selection" "backup_selection" {
  name         = "${var.backup_plan_name}-selection"
  plan_id      = aws_backup_plan.backup_plan.id
  iam_role_arn = aws_iam_role.backup_role.arn

  selection_tag {
    type  = "STRINGEQUALS"
    key   = var.backup_tag_key
    value = var.backup_tag_val
  }
}
