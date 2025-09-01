
provider "aws" {
    region = "us-east-1"

}

module "Samples" {                     # here we have to give the module name
    source = "./Modules/Module-1"               # path of the using modules( we have to give path from which path we are accessing the files
    ami_id =   "ami-084a7d336e816906b" # provide the ami value and also we have to use name we have mantioned in variables,tf file ex: ami_id and instance_type.
    instance_type = "t2.micro"
}

module "Samples1" {                     # here we have to give the module name
    source = "./Modules/Module-2"               # path of the using modules( we have to give path from which path we are accessing the files
    role_name             = "my-ec2-role"
    instance_profile_name = "my-instance-profile"
    backup_plan_name      = "Monthly-ec2-backup"
    backup_tag_key        = "backup"
    backup_tag_val        = "true"
    instance_id           = module.Samples.instance_id  # Use instance_id from Module-1
    backup_vault_name     = "ec2-backup-vault"
    backup_schedule       = "cron(0 3 1 * ? *)"  # 1st of every month at 3am utc
    backup_retention_days = 30
}

module "patch_manager" {
  source = "./Modules/Module-3"

  ssm_role_arn               = module.Samples1.ssm_role_arn
  maintenance_window_name    = "monthly-patch-window"
  maintenance_window_schedule = "cron(0 4 1 * ? *)"
  maintenance_window_duration = 2
  maintenance_window_cutoff  = 1
  patch_task_name            = "monthly-linux-patch-task"
  patch_task_priority        = 1
  patch_task_max_concurrency = "2"
  patch_task_max_errors      = "1"
  patch_log_group_name       = "patch-log-group"
  patch_log_retention_days   = 30
  target_instance_ids        = [module.Samples.instance_id]
}



