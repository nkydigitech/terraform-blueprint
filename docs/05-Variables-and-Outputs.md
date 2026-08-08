# Variables & Outputs: Making Code Dynamic

Hardcoding values (like a specific bucket name or container port) is a bad practice. It makes your code rigid and non-reusable.

## 📥 Variables (Inputs)
Variables allow you to pass values into your Terraform configuration.

### How to define them:
```hcl
variable "container_name" {
  description = "The name of our docker container"
  type        = string
  default     = "production-app"
}
```

### How to use them:
```hcl
resource "docker_container" "nginx" {
  name  = var.container_name
  # ...
}
```

## 📤 Outputs
Outputs are like "return values." They print information to your terminal after a successful `apply`. This is useful for getting IP addresses, URLs, or IDs of resources you just created.

### How to define them:
```hcl
output "container_id" {
  value = docker_container.nginx.id
}
```

## 🏗️ Modules: The Ultimate Reuse
Modules are containers for multiple resources that are used together.
- **Root Module**: The directory where you run `terraform apply`.
- **Child Module**: A separate directory that is "called" by the root module.

In our next lab, we will see how to pack our Docker logic into a module so we can launch 10 different apps with just a few lines of code.

---
[Next: Lab 03 - Modular Infrastructure →](../labs/03-modular-infra/README.md)
