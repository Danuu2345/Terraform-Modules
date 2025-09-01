output "maintenance_window_id" {
  description = "ID of the SSM Maintenance Window"
  value       = aws_ssm_maintenance_window.maintenance_window.id
}

output "maintenance_window_name" {
  description = "Name of the SSM Maintenance Window"
  value       = aws_ssm_maintenance_window.maintenance_window.name
}

output "patch_task_arn" {
  description = "ARN of the SSM Maintenance Window Task for patching"
  value       = aws_ssm_maintenance_window_task.patch_task.arn
}

output "patch_logs_group_name" {
  description = "CloudWatch Log Group name for patch management logs"
  value       = aws_cloudwatch_log_group.patch_log_group.name
}
