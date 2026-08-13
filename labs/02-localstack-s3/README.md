# Lab 02: LocalStack S3 — Create AWS Resources Locally (Free)

> **Your Fake AWS in a Box** — Create real S3 buckets without an AWS account, without a credit card, without a bill.

---

## 🎯 Objective

Create an AWS S3 bucket **locally** using LocalStack (a local AWS emulator). At the end, you will have a bucket called `blueprint-training-bucket` running on `localhost:4566`.

**The Analogy:** LocalStack is like a practice kitchen. You cook the same meals, use the same recipes (Terraform code), but nothing goes to the real restaurant (AWS). No bill, no risk, full learning.

---

## 💰 Cost Warning

- **$0.00** — Everything runs locally in Docker
- No AWS account needed
- No credit card needed

---

## 📋 Prerequisites

- Lab 01 completed (you know `terraform init`, `plan`, `apply`)
- Docker running (`docker ps` should work)
- VS Code installed

---

## 🔧 Step-by-Step

### Step 0: Start LocalStack (Your Fake AWS)

Open a **NEW** terminal window and keep it open.

```bash
docker run --rm -it -p 4566:4566 -p 4571:4571 localstack/localstack
```

**Expected Output:**
```
Ready.
```

You will see a lot of startup text. Wait until you see `Ready.` — that means your fake AWS is running.

> ⚠️ Leave this terminal open! This is your fake AWS cloud running in the background.

---

### Step 1: Create Lab Folder

Open a **SECOND** terminal (your main working terminal):

```bash
# If you are not in labs folder, go there
cd labs

# Create Lab 02 folder
mkdir 02-localstack-s3
cd 02-localstack-s3
```

**Expected Output:**
```
(nothing printed — you are now inside the 02-localstack-s3 folder)
```

Verify you are in the right place:
```bash
pwd
```

**Expected Output:**
```
/home/yourname/labs/02-localstack-s3
```

---

### Step 2: Create main.tf

```bash
code main.tf
```

Paste this exact content:

```hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  access_key                  = "test"
  secret_key                  = "test"
  region                      = "us-east-1"
  s3_use_path_style           = true
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    s3 = "http://localhost:4566"
  }
}

resource "aws_s3_bucket" "my_local_bucket" {
  bucket = "blueprint-training-bucket"
}
```

Save: `Ctrl + S`

**Expected Output:**
```
(nothing — file is saved. Check the blue dot on the tab disappeared)
```

---

### Step 3: Initialize Terraform

```bash
terraform init
```

**Expected Output:**
```
Initializing the backend...
Initializing provider plugins...
- Finding hashicorp/aws versions matching "~> 5.0"...
- Installing hashicorp/aws v5.x.x...
- Installed hashicorp/aws v5.x.x (signed by HashiCorp)
Terraform has been successfully initialized!
```

> ⚠️ If you get a Docker connection error, go back to your first terminal and make sure LocalStack is still running (you should see `Ready.`).

---

### Step 4: Plan (Preview What Will Happen)

```bash
terraform plan
```

**Expected Output:**
```
Terraform used the selected providers to generate the following execution plan:

  # aws_s3_bucket.my_local_bucket will be created
  + resource "aws_s3_bucket" "my_local_bucket" {
      + bucket = "blueprint-training-bucket"
      + id     = (known after apply)
    }

Plan: 1 to add, 0 to change, 0 to destroy.
```

The `+` sign means "this will be created". Nothing exists yet — we are just previewing.

---

### Step 5: Apply (Create the Bucket)

```bash
terraform apply
```

Type `yes` when asked.

**Expected Output:**
```
aws_s3_bucket.my_local_bucket: Creating...
aws_s3_bucket.my_local_bucket: Creation complete after 1s [id=blueprint-training-bucket]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
```

---

### Step 6: Verify the Bucket Exists

We told Terraform to use `http://localhost:4566` instead of real AWS. Let us verify the bucket is actually there:

```bash
aws --endpoint-url=http://localhost:4566 s3 ls
```

**Expected Output:**
```
2026-08-13 10:00:00 blueprint-training-bucket
```

You should see your bucket name listed. That is your bucket, created by Terraform, running locally.

Or verify with curl:
```bash
curl http://localhost:4566/blueprint-training-bucket
```

**Expected Output:**
```
<?xml version="1.0" encoding="UTF-8"?>
<ListBucketResult>
  ... (XML showing the empty bucket)
```

---

### Step 7: Destroy (Clean Up)

```bash
terraform destroy
```

Type `yes` when asked.

**Expected Output:**
```
aws_s3_bucket.my_local_bucket: Destroying...
aws_s3_bucket.my_local_bucket: Destruction complete after 0s

Destroy complete! Resources: 1 destroyed.
```

Now go to your first terminal (LocalStack) and press `Ctrl + C` to stop it.

---

## ✅ What You Learned

1. LocalStack lets you practice AWS locally without an account or bill
2. Terraform works the same way with LocalStack as with real AWS
3. The `endpoints` block redirects Terraform to localhost instead of AWS
4. `terraform destroy` removes everything you created
5. You can verify resources with the AWS CLI using `--endpoint-url`

---

## 🧹 Cleanup

Already done in Step 7. Your LocalStack container stops when you press `Ctrl + C`.
