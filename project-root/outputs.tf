


output "public_ip" {
  value       = module.Samples.public_ip  #outputs that reference values from the Samples module
  description = "Public IP Address of EC2 instance"   #public_ip value from the Samples module
}

output "instance_id" {
  value       = module.Samples.instance_id
  description = "Instance ID"
}

output "backup_vault_name" {
  value       = module.Samples1.backup_vault_name
  description = "Name of the backup vault"
}

output "backup_plan_id" {
  value       = module.Samples1.backup_plan_id
  description = "ID of the backup plan"
}

output "backup_selection_id" {
  value       = module.Samples1.backup_selection_id
  description = "ID of the backup selection"
}

output "backup_vault_arn" {
  value       = module.Samples1.backup_vault_arn
  description = "ARN of the backup vault"
}

output "maintenance_window_id" {
  value       = module.patch_manager.maintenance_window_id
  description = "ID of the SSM Maintenance Window for monthly patching"
}

output "maintenance_window_name" {
  value       = module.patch_manager.maintenance_window_name
  description = "Name of the SSM Maintenance Window for monthly patching"
}
output "patch_task_arn" {
  value       = module.patch_manager.patch_task_arn
  description = "ARN of the SSM Maintenance Window Task for patching"
}

output "patch_logs_group_name" {
  value       = module.patch_manager.patch_logs_group_name
  description = "CloudWatch Log Group name for patch management logs"
}

