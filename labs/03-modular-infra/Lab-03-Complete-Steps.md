# Lab 03: Modular Infra - Complete Step-by-Step (The Hero Lab)

**Goal:** Learn DRY (Don't Repeat Yourself). Write code ONCE, use it TWICE to create frontend on 8081 and backend on 8082.

### Step 1: Create Folder Structure

This is the structure you described - let's build it exactly:

```bash
cd labs
mkdir 03-modular-infra
cd 03-modular-infra

# Create modules folder
mkdir -p modules/docker_app
```

Check:
```
03-modular-infra/
└── modules/
    └── docker_app/
```

### Step 2: Create the Module (Your Blueprint)

This is the reusable part. Go into module folder:

```bash
cd modules/docker_app
```

Create 3 files:

**File 1: main.tf**
```bash
code main.tf
```
Paste:
```hcl
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

provider "docker" {}

resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = false
}

resource "docker_container" "app" {
  image = docker_image.nginx.image_id
  name  = var.container_name
  ports {
    internal = 80
    external = var.external_port
  }
}
```

**File 2: variables.tf**
```bash
code variables.tf
```
Paste:
```hcl
variable "container_name" {
  description = "Name of the container"
  type        = string
}

variable "external_port" {
  description = "External port to expose"
  type        = number
}
```

**File 3: outputs.tf**
```bash
code outputs.tf
```
Paste:
```hcl
output "container_name" {
  value = docker_container.app.name
}
```

Now go back to root of Lab 03:
```bash
cd ../..
# you should be in 03-modular-infra
```

### Step 3: Create Root main.tf (Where You USE the Module)

```bash
code main.tf
```
Paste:
```hcl
module "app_frontend" {
  source         = "./modules/docker_app"
  container_name = "frontend-server"
  external_port  = 8081
}

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
```

### Step 4: Init, Plan, Apply (Important: Module Needs Init!)

```bash
terraform init
terraform plan
terraform apply
```
Type `yes`.

### Step 5: Verify TWO Websites!

Open:
- http://localhost:8081  -> Frontend
- http://localhost:8082  -> Backend

Both show nginx! You wrote code once, used twice.

```bash
docker ps
```
You will see frontend-server and backend-server.

### Step 6: Destroy

```bash
terraform destroy
```
Type `yes`.
