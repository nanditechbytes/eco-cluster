output "main_ecs_cluster" {
  value       = aws_ecs_cluster.main
  description = "The grouping of tasks, and services, and the shared capacity and configurations utilized by each."
}

output "secrets_output" {
  value       = aws_secretsmanager_secret.main_secretsmanager_secret_environment_secrets
  description = "The secrets manager instance which has been created for environment secrets"
}