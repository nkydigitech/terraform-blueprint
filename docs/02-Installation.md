# Installation Guide

To follow this course, you need the Terraform CLI installed on your machine.

## 🪟 Windows (Recommended: Chocolatey or Winget)

### Using Winget:
```powershell
winget install Hashicorp.Terraform
```

### Using Chocolatey:
```powershell
choco install terraform
```

## 🍎 macOS (Using Homebrew)

```bash
brew tap hashicorp/tap
brew install hashicorp/tap/terraform
```

## 🐧 Linux (Ubuntu/Debian)

```bash
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
wget -O- https://apt.releases.hashicorp.com/gpg | \
gpg --dearmor | \
sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
gpg --no-default-keyring \
--keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
--fingerprint
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update
sudo apt-get install terraform
```

## ✅ Verify Installation

Open your terminal and run:
```bash
terraform -version
```
You should see something like: `Terraform v1.x.x`

## 🐳 Docker (Mandatory for Labs)
Since we are using a **Local-First** approach, please ensure Docker is installed and running.

[Download Docker Desktop](https://www.docker.com/products/docker-desktop/)

---
[Next: The Basic Workflow →](03-Basic-Workflow.md)
