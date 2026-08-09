# Lab 01: Hello Docker - Complete Step-by-Step for Novices

Welcome! In this lab, you will create your FIRST infrastructure — an Nginx web server running in Docker — using Terraform. No AWS needed.

**What you will have at the end:** A website at http://localhost:8000

---

### Step 0: Open Your Terminal

**Windows:** Press `Win + R` -> type `powershell` -> Enter
**Mac:** Press `Cmd + Space` -> type `Terminal` -> Enter

Check Terraform is installed:
```bash
terraform -version
```
You should see `Terraform v1.x.x`. If not, go back to Installation Guide.

Check Docker is running:
```bash
docker ps
```
Should not error. If it errors, open Docker Desktop and wait until it says "Running".

---

### Step 1: Create the Lab Folder

We will create the folder structure from scratch.

```bash
# Create main labs folder (if you don't have it)
mkdir labs

# Go into labs
cd labs

# Create Lab 01 folder
mkdir 01-hello-docker

# Go into it
cd 01-hello-docker
```

Your terminal path should now be `.../labs/01-hello-docker`

---

### Step 2: Create main.tf

This is the file where we write Terraform code.

**Option A - Using VS Code (Recommended):**
```bash
code main.tf
```
VS Code will open. Paste the code below.

**Option B - Using Notepad (Windows):**
```bash
notepad main.tf
```
Paste, then Save.

**Paste THIS exact content into main.tf:**

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

resource "docker_container" "nginx" {
  image = docker_image.nginx.image_id
  name  = "tutorial"
  ports {
    internal = 80
    external = 8000
  }
}
```

Save the file: `Ctrl + S`

---

### Step 3: Initialize Terraform

This downloads the Docker provider. Think of it like `npm install`.

```bash
terraform init
```

You should see: `Terraform has been successfully initialized!`

---

### Step 4: See What Will Happen (Plan)

This shows you what Terraform WILL do, without doing it.

```bash
terraform plan
```

You should see:
```
+ docker_image.nginx
+ docker_container.nginx
Plan: 2 to add, 0 to change, 0 to destroy
```

---

### Step 5: Build It (Apply)

Now we create the real container.

```bash
terraform apply
```

Terraform will ask: `Do you want to perform these actions?` Type `yes` and press Enter.

Wait 30 seconds. You should see: `Apply complete! Resources: 2 added`

---

### Step 6: See It In Your Browser!

Open Chrome/Firefox and go to:

**http://localhost:8000**

You should see **"Welcome to nginx!"** — You just did Infrastructure as Code!

You can also verify in terminal:
```bash
docker ps
```
You will see `tutorial` running.

---

### Step 7: Clean Up (Destroy)

When done, remove it:

```bash
terraform destroy
```
Type `yes`.

---

### What Just Happened?

1. `mkdir` = Make folder
2. `main.tf` = Your blueprint
3. `terraform init` = Download tools
4. `terraform plan` = Preview
5. `terraform apply` = Build
6. `terraform destroy` = Remove

Next: [Lab 02: LocalStack S3 →](../02-localstack-s3/README.md)
