variable "role_name" {
  description = "Name of the IAM role for SSM access"
  type        = string
  default     = "ec2-ssm-role"
}

variable "instance_profile_name" {
  description = "Name of the IAM instance profile for SSM access"
  type        = string
  default     = "ec2-ssm-profile"
}

variable "backup_plan_name" {
  description = "Name of the AWS Backup plan"
  type        = string
}

variable "backup_tag_key" {
  description = "Tag key used for backup selection"
  type        = string
}

variable "backup_tag_val" {
  description = "Tag value used for backup selection"
  type        = string
}

variable "instance_id" {
  description = "EC2 instance ID to backup"
  type        = string
}

variable "backup_vault_name" {
  description = "Name of the backup vault"
  type        = string
}

variable "backup_schedule" {
  description = "Backup schedule in cron format"
  type        = string
}

variable "backup_retention_days" {
  description = "Number of days to retain backups"
  type        = number
}
