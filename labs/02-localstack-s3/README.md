# Lab 02: LocalStack S3 - Complete Step-by-Step

**Goal:** Create an AWS S3 bucket LOCALLY without AWS account. At the end, you will have bucket `blueprint-training-bucket` running on `localhost:4566`.

### Step 0: Start LocalStack (Your Fake AWS)

Open a **NEW** terminal window and keep it open.

```bash
docker run --rm -it -p 4566:4566 -p 4571:4571 localstack/localstack
```

Wait until you see `Ready.`

Leave this terminal open! This is your fake AWS cloud.

### Step 1: Create Lab Folder

Open a **SECOND** terminal (your main one):

```bash
# If you are not in labs folder, go there
cd labs

# Create Lab 02 folder
mkdir 02-localstack-s3
cd 02-localstack-s3
```

### Step 2: Create main.tf

```bash
code main.tf
```

Paste this:

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

### Step 3: Init, Plan, Apply

```bash
terraform init
terraform plan
terraform apply
```
Type `yes` when asked.

### Step 4: Verify Bucket Exists (Secret Sauce)

We told AWS provider to use `http://localhost:4566` not real AWS! Check:

```bash
aws --endpoint-url=http://localhost:4566 s3 ls
```
You should see `blueprint-training-bucket`

Or use this curl:
```bash
curl http://localhost:4566/blueprint-training-bucket
```

### Step 5: Destroy

```bash
terraform destroy
```
Type `yes`.

Then go to your first terminal (LocalStack) and press `Ctrl + C` to stop it.
