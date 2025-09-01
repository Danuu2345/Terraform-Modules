variable "ssm_role_arn" {
  description = "ARN of the IAM role for SSM patch management"
  type        = string
}

variable "maintenance_window_name" {
  description = "Name of the SSM maintenance window"
  type        = string
}

variable "maintenance_window_schedule" {
  description = "Schedule for the maintenance window in cron format"
  type        = string
}

variable "maintenance_window_duration" {
  description = "Duration of the maintenance window in hours"
  type        = number
}

variable "maintenance_window_cutoff" {
  description = "Cutoff time for the maintenance window in hours"
  type        = number
}

variable "patch_task_name" {
  description = "Name of the patch task"
  type        = string
}

variable "patch_task_priority" {
  description = "Priority of the patch task"
  type        = number
}

variable "patch_task_max_concurrency" {
  description = "Maximum concurrency for the patch task"
  type        = string
}

variable "patch_task_max_errors" {
  description = "Maximum errors allowed for the patch task"
  type        = string
}

variable "patch_log_group_name" {
  description = "Name of the CloudWatch log group for patch logs"
  type        = string
}

variable "patch_log_retention_days" {
  description = "Retention period for patch logs in days"
  type        = number
}

variable "target_instance_ids" {
  description = "List of EC2 instance IDs to target for patching"
  type        = list(string)
  default     = []
}
