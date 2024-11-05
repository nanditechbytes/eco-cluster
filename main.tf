locals {
  tags = merge(var.tags, {
    application-id = data.aws_ssm_parameter.application_id.value
    application    = data.aws_ssm_parameter.application_name.value
    cost-center    = data.aws_ssm_parameter.cost_center.value
    env            = data.aws_ssm_parameter.env.value
    owner-email    = data.aws_ssm_parameter.owner_email.value
  })
}

resource "aws_ecs_cluster" "main" {
  name = var.name
  dynamic "configuration" {
    for_each = (var.configuration != null) ? [var.configuration] : []
    content {
      dynamic "execute_command_configuration" {
        for_each = flatten([try(configuration.value.execute_command_configuration, [])])
        content {

          logging    = execute_command_configuration.value.logging
          kms_key_id = execute_command_configuration.value.kms_key_id
          dynamic "log_configuration" {
            for_each = flatten([try(execute_command_configuration.value.log_configuration, [])])
            content {
              cloud_watch_encryption_enabled = log_configuration.value.cloud_watch_encryption_enabled
              cloud_watch_log_group_name     = log_configuration.value.cloud_watch_log_group_name
              s3_bucket_name                 = log_configuration.value.s3_bucket_name
              s3_bucket_encryption_enabled   = log_configuration.value.s3_bucket_encryption_enabled
              s3_key_prefix                  = log_configuration.value.s3_key_prefix
            }
          }
        }
      }
    }
  }

  dynamic "setting" {
    for_each = flatten([try(var.settings, [])])
    content {
      name  = setting.value.name
      value = setting.value.value
    }
  }
  tags = merge(local.tags, { "resource-name" : "Amazon ECS cluster" })

}

resource "aws_secretsmanager_secret" "main_secretsmanager_secret_environment_secrets" {
  for_each = { for data in var.secrets : data => data }
  name     = "user-${each.key}"
  tags     = merge(local.tags, { "resource-name" : "AWS Secrets Manager" })
}