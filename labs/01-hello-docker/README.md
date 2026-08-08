# Lab 01: Hello Docker 🐳

In this first lab, we will use Terraform to deploy a simple Nginx web server running in a Docker container.

## Prerequisites
- [Docker Desktop](https://www.docker.com/products/docker-desktop/) installed and running.
- Terraform CLI installed.

## Step 1: Initialize the Directory
Open your terminal in this folder (`labs/01-hello-docker/`) and run:
```bash
terraform init
```
*What happens?* Terraform downloads the **Docker Provider**, which allows it to talk to the Docker API.

## Step 2: Plan your Infrastructure
Run:
```bash
terraform plan
```
*What happens?* Terraform reads your `main.tf` file and shows you exactly what it will create. It should show 2 resources to be added (the image and the container).

## Step 3: Apply the Changes
Run:
```bash
terraform apply
```
When prompted, type `yes`.

*What happens?* Terraform pulls the Nginx image and starts a container named `tutorial`.

## Step 4: Verify
Open your browser and go to: [http://localhost:8000](http://localhost:8000). You should see the "Welcome to nginx!" page.

## Step 5: Clean Up
Infrastructure should be temporary. To destroy everything we just built, run:
```bash
terraform destroy
```
Type `yes` when prompted.

---
[Back to main course →](../../README.md)
