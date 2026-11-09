# --- Connexion au moteur Docker ---
variable "docker_host" {
  description = "Adresse du démon Docker (Windows: npipe, Linux/CI: socket unix)."
  type        = string
  default     = "npipe:////./pipe/docker_engine"
}

# --- Variables de Base de Données (PostgreSQL) ---
variable "db_name" {
  description = "Nom de la base de données PostgreSQL."
  type        = string
  default     = "devops_db"
}

variable "db_user" {
  description = "Nom d'utilisateur PostgreSQL."
  type        = string
  default     = "devops_user"
}

variable "db_password" {
  description = "Mot de passe PostgreSQL (simulé, ne pas utiliser en production)."
  type        = string
  default     = "newpassword456"
  sensitive   = true
}

# --- Variables d'Application ---
variable "app_port_external" {
  description = "Port externe de l'application web (mappé au port 80 interne)."
  type        = number
  default     = 8080
}
