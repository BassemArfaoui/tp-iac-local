# --- Configuration Terraform et Provider ---
terraform {
  required_version = ">= 1.0"
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {
  host = var.docker_host
}

# --- 1. Base de Données PostgreSQL ---
resource "docker_image" "postgres_image" {
  name         = "postgres:latest"
  keep_locally = true
}

resource "docker_container" "db_container" {
  name  = "tp-db-postgres"
  image = docker_image.postgres_image.image_id

  ports {
    internal = 5432
    external = 5432
  }

  env = [
    "POSTGRES_USER=${var.db_user}",
    "POSTGRES_PASSWORD=${var.db_password}",
    "POSTGRES_DB=${var.db_name}",
  ]
}

# --- 2. Application Web Nginx ---
# Construit l'image à partir du Dockerfile_app local via la CLI Docker
# (le bloc "build" du provider bloque avec Docker Desktop sous Windows)
resource "terraform_data" "app_build" {
  # Reconstruit l'image si le Dockerfile change
  triggers_replace = [filesha1("${path.module}/Dockerfile_app")]

  provisioner "local-exec" {
    working_dir = path.module
    command     = "docker build -f Dockerfile_app -t tp-web-app:latest ."
  }
}

# Référence l'image construite localement
resource "docker_image" "app_image" {
  name         = "tp-web-app:latest"
  keep_locally = true
  depends_on   = [terraform_data.app_build]
}

resource "docker_container" "app_container" {
  name  = "tp-app-web"
  image = docker_image.app_image.image_id

  # La DB doit être créée avant l'application
  depends_on = [docker_container.db_container]

  ports {
    internal = 80
    external = var.app_port_external
  }
}
