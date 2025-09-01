# CloudWatch Log Group for patch logs
resource "aws_cloudwatch_log_group" "patch_log_group" {
  name              = var.patch_log_group_name
  retention_in_days = var.patch_log_retention_days
}

# SSM Maintenance Window
resource "aws_ssm_maintenance_window" "maintenance_window" {
  name     = var.maintenance_window_name
  schedule = var.maintenance_window_schedule
  duration = var.maintenance_window_duration
  cutoff   = var.maintenance_window_cutoff
}

# Maintenance Window Target
resource "aws_ssm_maintenance_window_target" "maintenance_window_target" {
  window_id     = aws_ssm_maintenance_window.maintenance_window.id
  name          = "${var.maintenance_window_name}-target"
  description   = "Target for patch maintenance"
  resource_type = "INSTANCE"

  targets {
    key    = "InstanceIds"
    values = var.target_instance_ids
  }
}

# Patch Task
resource "aws_ssm_maintenance_window_task" "patch_task" {
  window_id        = aws_ssm_maintenance_window.maintenance_window.id
  name             = var.patch_task_name
  description      = "Task to apply patches"
  task_type        = "RUN_COMMAND"
  task_arn         = "AWS-RunPatchBaseline"
  priority         = var.patch_task_priority
  service_role_arn = var.ssm_role_arn
  max_concurrency  = var.patch_task_max_concurrency
  max_errors       = var.patch_task_max_errors

  targets {
    key    = "WindowTargetIds"
    values = [aws_ssm_maintenance_window_target.maintenance_window_target.id]
  }

  task_invocation_parameters {
    run_command_parameters {
      comment         = "Apply patches"
      timeout_seconds = 3600

      parameter {
        name   = "Operation"
        values = ["Install"]
      }

      parameter {
        name   = "RebootOption"
        values = ["RebootIfNeeded"]
      }

      cloudwatch_config {
        cloudwatch_log_group_name = aws_cloudwatch_log_group.patch_log_group.name
        cloudwatch_output_enabled = true
      }
    }
  }
}
