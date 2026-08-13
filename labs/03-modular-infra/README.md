# Lab 03: Modular Infra — Write Once, Use Twice (The Hero Lab)

> **The Factory Blueprint** — Write one recipe, cook two meals. That is what modules do for infrastructure.

---

## 🎯 Objective

Learn DRY (Don't Repeat Yourself). Write Terraform code **ONCE** as a module, then use it **TWICE** to create a frontend server on port 8081 and a backend server on port 8082.

**The Analogy:** Think of a module like a posh restaurant menu item. You write the recipe once (the module), then order it twice with different table numbers (frontend on 8081, backend on 8082). The kitchen (Terraform) handles the rest.

---

## 💰 Cost Warning

- **$0.00** — Everything runs locally in Docker
- No AWS account needed

---

## 📋 Prerequisites

- Lab 01 and Lab 02 completed
- Docker running
- VS Code installed
- You understand `terraform init`, `plan`, `apply`, `destroy`

---

## 🔧 Step-by-Step

### Step 1: Create Folder Structure

```bash
cd labs
mkdir 03-modular-infra
cd 03-modular-infra

# Create modules folder
mkdir -p modules/docker_app
```

**Expected Output:**
```
(nothing printed — folders created silently)
```

Verify the structure:
```bash
tree
```

**Expected Output:**
```
.
└── modules
    └── docker_app

3 directories, 0 files
```

> ⚠️ If `tree` is not installed, use `find . -type d` instead.

---

### Step 2: Create the Module (Your Reusable Blueprint)

Go into the module folder:

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

Save: `Ctrl + S`

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

Save: `Ctrl + S`

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

Save: `Ctrl + S`

Verify all 3 files exist:
```bash
ls -la
```

**Expected Output:**
```
total 12
-rw-r--r-- 1 user user  450 Aug 13 10:00 main.tf
-rw-r--r-- 1 user user  120 Aug 13 10:00 outputs.tf
-rw-r--r-- 1 user user  180 Aug 13 10:00 variables.tf
```

Now go back to the root of Lab 03:
```bash
cd ../..
```

**Expected Output:**
```
(nothing — you are now back in 03-modular-infra)
```

Verify:
```bash
pwd
```

**Expected Output:**
```
/home/yourname/labs/03-modular-infra
```

---

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

Save: `Ctrl + S`

---

### Step 4: Initialize Terraform (Important: Modules Need Init!)

```bash
terraform init
```

**Expected Output:**
```
Initializing modules...
- app_frontend in modules/docker_app
- app_backend in modules/docker_app

Initializing the backend...
Initializing provider plugins...
- Finding kreuzwerker/docker versions matching "~> 3.0.1"...
- Installing kreuzwerker/docker v3.0.1...
- Installed kreuzwerker/docker v3.0.1
Terraform has been successfully initialized!
```

> ⚠️ If you see an error about modules not found, make sure your folder structure matches Step 1. Run `tree` to verify.

---

### Step 5: Plan (Preview)

```bash
terraform plan
```

**Expected Output:**
```
Terraform used the selected providers to generate the following execution plan:

  # module.app_backend.docker_container.app will be created
  + resource "docker_container" "app" {
      + name = "backend-server"
      + ports { internal = 80, external = 8082 }
    }

  # module.app_backend.docker_image.nginx will be created
  + resource "docker_image" "nginx" {
      + name = "nginx:latest"
    }

  # module.app_frontend.docker_container.app will be created
  + resource "docker_container" "app" {
      + name = "frontend-server"
      + ports { internal = 80, external = 8081 }
    }

  # module.app_frontend.docker_image.nginx will be created
  + resource "docker_image" "nginx" {
      + name = "nginx:latest"
    }

Plan: 4 to add, 0 to change, 0 to destroy.
```

Notice: 4 resources — 2 images + 2 containers. One module, used twice = double the resources.

---

### Step 6: Apply (Build Everything)

```bash
terraform apply
```

Type `yes` when asked.

**Expected Output:**
```
module.app_backend.docker_image.nginx: Creating...
module.app_backend.docker_image.nginx: Creation complete after 5s
module.app_frontend.docker_image.nginx: Creating...
module.app_frontend.docker_image.nginx: Creation complete after 2s
module.app_backend.docker_container.app: Creating...
module.app_backend.docker_container.app: Creation complete after 1s [id=abc123]
module.app_frontend.docker_container.app: Creating...
module.app_frontend.docker_container.app: Creation complete after 1s [id=def456]

Apply complete! Resources: 4 added, 0 changed, 0 destroyed.

Outputs:
backend_name = "backend-server"
frontend_name = "frontend-server"
```

---

### Step 7: Verify TWO Websites Are Running

Open in your browser:
- http://localhost:8081 — Frontend
- http://localhost:8082 — Backend

**Expected Output (in browser):**
```
Welcome to nginx!
```

Both should show the Nginx welcome page. You wrote code once, used twice.

Verify containers are running:
```bash
docker ps
```

**Expected Output:**
```
CONTAINER ID   IMAGE          STATUS         PORTS                  NAMES
abc123         nginx:latest   Up 10 seconds  0.0.0.0:8081->80/tcp   frontend-server
def456         nginx:latest   Up 10 seconds  0.0.0.0:8082->80/tcp   backend-server
```

You should see both `frontend-server` and `backend-server` running with different port mappings.

---

### Step 8: Destroy (Clean Up)

```bash
terraform destroy
```

Type `yes` when asked.

**Expected Output:**
```
module.app_backend.docker_container.app: Destroying...
module.app_backend.docker_container.app: Destruction complete after 0s
module.app_frontend.docker_container.app: Destroying...
module.app_frontend.docker_container.app: Destruction complete after 0s
module.app_backend.docker_image.nginx: Destroying...
module.app_backend.docker_image.nginx: Destroying...
module.app_frontend.docker_image.nginx: Destroying...
module.app_frontend.docker_image.nginx: Destroying...

Destroy complete! Resources: 4 destroyed.
```

Verify containers are gone:
```bash
docker ps
```

**Expected Output:**
```
CONTAINER ID   IMAGE   STATUS   PORTS   NAMES
```

Empty list means all containers are gone. Clean slate.

---

## ✅ What You Learned

1. Modules let you write infrastructure code ONCE and reuse it multiple times
2. Variables make modules flexible (same module, different names and ports)
3. Outputs let you see results after `terraform apply`
4. One module used twice = 4 resources created (2 images + 2 containers)
5. `terraform destroy` cleans up everything created by the module

---

## 🧹 Cleanup

Already done in Step 8. All containers and images are removed.

