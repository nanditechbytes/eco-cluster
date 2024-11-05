variable "name" {
  type        = string
  description = "name of the cluster"
}

variable "settings" {
  type = object({
    name  = string
    value = string
  })
  default     = null
  description = "Configuration block(s) with cluster settings. For example, this can be used to enable CloudWatch Container Insights for a cluster."
}

variable "configuration" {
  type = object({
    execute_command_configuration = optional(object({
      kms_key_id = optional(string)
      log_configuration = optional(object({
        cloud_watch_encryption_enabled = optional(bool)
        cloud_watch_log_group_name     = optional(string)
        s3_bucket_name                 = optional(string)
        s3_bucket_encryption_enabled   = optional(bool)
        s3_key_prefix                  = optional(string)
      }))
    }))
  })
  default     = null
  description = "The execute command configuration for the cluster."
}

variable "secrets" {
  type        = list(string)
  default     = []
  description = "Secrets which will be created for services running on this cluster"
}

variable "tags" {
  type        = map(string)
  description = "Additional tags to add to the rds. By default, the module will add application-id, application, cost-center, env and owner-email"
  default     = {}
}