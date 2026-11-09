output "db_container_name" {
  description = "Nom du conteneur PostgreSQL."
  value       = docker_container.db_container.name
}

output "db_connection" {
  description = "Infos de connexion à la base."
  value       = "postgresql://${var.db_user}@localhost:5432/${var.db_name}"
}

output "app_container_name" {
  description = "Nom du conteneur de l'application web."
  value       = docker_container.app_container.name
}

output "app_url" {
  description = "URL d'accès à l'application."
  value       = "http://localhost:${var.app_port_external}/"
}
