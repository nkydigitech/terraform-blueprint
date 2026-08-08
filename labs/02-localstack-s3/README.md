# Lab 02: LocalStack S3 ☁️

In this lab, we graduate from Docker to simulating **Amazon Web Services (AWS)** locally using **LocalStack**. We will create an S3 bucket (storage) without ever logging into a cloud console.

## Prerequisites
- [Docker Desktop](https://www.docker.com/products/docker-desktop/) running.
- [LocalStack CLI](https://docs.localstack.cloud/getting-started/installation/) (Optional, but recommended) or just use Docker.

## Step 1: Start LocalStack
Run this command in your terminal to start a local AWS environment:
```bash
docker run --rm -it -p 4566:4566 -p 4571:4571 localstack/localstack
```
Keep this terminal open.

## Step 2: Initialize
In a new terminal, navigate to `labs/02-localstack-s3/` and run:
```bash
terraform init
```

## Step 3: Plan and Apply
Run:
```bash
terraform plan
terraform apply
```

## Step 4: The "Secret Sauce"
Look at `main.tf`. Notice how we told the `aws` provider to use `http://localhost:4566` instead of the real AWS cloud? This is a powerful way to test your code for free!

## Step 5: Clean Up
```bash
terraform destroy
```
Then you can stop the LocalStack Docker container.

---
[Back to main course →](../../README.md)
