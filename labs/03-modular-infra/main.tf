terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

provider "docker" {}

# Call our first app
module "app_frontend" {
  source         = "./modules/docker_app"
  container_name = "frontend-server"
  external_port  = 8081
}

# Call our second app (using the same module!)
module "app_backend" {
  source         = "./modules/docker_app"
  container_name = "backend-server"
  external_port  = 8082
}

output "frontend_name" {
  value = module.app_frontend.container_name
}

output "backend_name" {
  value = module.app_backend.container_name
}
