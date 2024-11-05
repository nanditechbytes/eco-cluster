<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.6  |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0  |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.0  |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ecs_cluster.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_cluster) | resource |
| [aws_secretsmanager_secret.main_secretsmanager_secret_environment_secrets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_ssm_parameter.application_id](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssm_parameter) | data source |
| [aws_ssm_parameter.application_name](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssm_parameter) | data source |
| [aws_ssm_parameter.cost_center](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssm_parameter) | data source |
| [aws_ssm_parameter.env](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssm_parameter) | data source |
| [aws_ssm_parameter.owner_email](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssm_parameter) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | name of the cluster | `string` | n/a | yes |
| <a name="input_configuration"></a> [configuration](#input\_configuration) | The execute command configuration for the cluster. | <pre>object({<br>    execute_command_configuration = optional(object({<br>      kms_key_id = optional(string)<br>      log_configuration = optional(object({<br>        cloud_watch_encryption_enabled = optional(bool)<br>        cloud_watch_log_group_name     = optional(string)<br>        s3_bucket_name                 = optional(string)<br>        s3_bucket_encryption_enabled   = optional(bool)<br>        s3_key_prefix                  = optional(string)<br>      }))<br>    }))<br>  })</pre> | `null` | no |
| <a name="input_secrets"></a> [secrets](#input\_secrets) | Secrets which will be created for services running on this cluster | `list(string)` | `[]` | no |
| <a name="input_settings"></a> [settings](#input\_settings) | Configuration block(s) with cluster settings. For example, this can be used to enable CloudWatch Container Insights for a cluster. | <pre>object({<br>    name  = string<br>    value = string<br>  })</pre> | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags to add to the rds. By default, the module will add application-id, application, cost-center, env and owner-email | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_main_ecs_cluster"></a> [main\_ecs\_cluster](#output\_main\_ecs\_cluster) | The grouping of tasks, and services, and the shared capacity and configurations utilized by each. |
| <a name="output_secrets_output"></a> [secrets\_output](#output\_secrets\_output) | The secrets manager instance which has been created for environment secrets |
<!-- END_TF_DOCS -->