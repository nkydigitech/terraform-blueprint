variable "container_name" {
  type    = string
  default = "my-modular-app"
}

variable "external_port" {
  type    = number
  default = 8080
}

resource "docker_image" "nginx" {
  name = "nginx:latest"
}

resource "docker_container" "nginx" {
  name  = var.container_name
  image = docker_image.nginx.image_id
  ports {
    internal = 80
    external = var.external_port
  }
}

output "container_name" {
  value = docker_container.nginx.name
}
