output "backup_vault_name" {
  description = "Name of the backup vault"
  value       = aws_backup_vault.vault.name
}

output "backup_plan_id" {
  description = "ID of the backup plan"
  value       = aws_backup_plan.backup_plan.id
}

output "backup_selection_id" {
  description = "ID of the backup selection"
  value       = aws_backup_selection.backup_selection.id
}

output "backup_vault_arn" {
  description = "ARN of the backup vault"
  value       = aws_backup_vault.vault.arn
}

output "backup_role_arn" {
  description = "ARN of the backup IAM role"
  value       = aws_iam_role.backup_role.arn
}

output "ssm_role_arn" {
  description = "ARN of the SSM IAM role"
  value       = aws_iam_role.ssm_role.arn
}
