# The Basic Workflow

Terraform follows a simple, repeatable lifecycle. Understanding this "Big Three" is essential for every engineer.

## 1. `terraform init` (The Setup)
Think of this like `npm install` or `git init`.
- It initializes the working directory.
- It downloads the **Providers** (plugins) required to talk to your target environment (Docker, AWS, etc.).
- It sets up the **Backend** where your state file will be stored.

## 2. `terraform plan` (The Preview)
This is your safety net.
- It compares your current state with your code.
- It creates an execution plan.
- **It makes NO changes** to your actual infrastructure.
- Always run this to catch mistakes before they happen.

## 3. `terraform apply` (The Action)
This is where the magic happens.
- It executes the plan.
- It creates, updates, or deletes resources to match your code.
- It updates the **State File** (`terraform.tfstate`) to reflect the new reality.

## 🏁 The Bonus: `terraform destroy`
Used to tear down everything managed by your configuration. Use with caution!

---
[Next: Lab 01 - Hello Docker →](../labs/01-hello-docker/README.md)
