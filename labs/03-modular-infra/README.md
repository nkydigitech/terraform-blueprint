# Lab 03: Modular Infrastructure 🏗️

Welcome to the "Hero" phase! In this lab, we will learn how to build **Reusable Modules**. This is how real companies manage hundreds of servers without writing thousands of lines of duplicate code.

## The Goal
Instead of defining a `docker_container` resource every time we want a new app, we will create a `docker_app` module and "call" it twice.

## Step 1: Explore the Structure
- `modules/docker_app/`: This is our blueprint. It defines what an "app" looks like.
- `main.tf` (in the root): This is where we "call" the blueprint to create two different apps (`frontend-server` and `backend-server`).

## Step 2: Initialize
```bash
terraform init
```
*Note*: Every time you add a module, you must run `init` so Terraform can map the source.

## Step 3: Plan and Apply
```bash
terraform plan
terraform apply
```

## Step 4: Verify
You should now have TWO containers running:
1.  [http://localhost:8081](http://localhost:8081) (Frontend)
2.  [http://localhost:8082](http://localhost:8082) (Backend)

## Step 5: Reflect
We wrote the resource logic **once** in the module, and used it **twice** in our main file. This is the power of DRY (Don't Repeat Yourself) in Terraform.

---
[Congratulations! Head back to the main README to finish the course.](../../README.md)
