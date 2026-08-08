# What is Terraform?

Terraform is an **Infrastructure as Code (IaC)** tool created by HashiCorp. It allows you to define both cloud and on-premise resources in human-readable configuration files that you can version, reuse, and share.

## The Core Concept: Declarative vs. Imperative

- **Imperative (Manual/Scripted)**: "Step 1: Create a VPC. Step 2: Create a Subnet. Step 3: Launch an EC2." If Step 2 fails, your script breaks.
- **Declarative (Terraform)**: "I want a VPC, a Subnet, and an EC2 instance." You define the *desired state*, and Terraform figures out how to make it happen.

## Key Features

### 1. Execution Plans
Terraform has a "planning" step where it generates an *execution plan*. This shows you exactly what it will do before it does it. No more surprises!

### 2. Resource Graph
Terraform builds a graph of all your resources and maps their dependencies. This allows it to create resources in parallel whenever possible, making deployments fast.

### 3. Change Automation
When you update your configuration, Terraform only applies the necessary changes to reach the desired state. It won't recreate everything from scratch unless it has to.

## Why "Local-First"?
In this course, we start with **Docker** and **LocalStack**. This allows you to learn Terraform without:
- Setting up complex cloud accounts.
- Worrying about unexpected bills.
- Needing an active internet connection for every step.

---
[Next: Installation Guide →](02-Installation.md)
