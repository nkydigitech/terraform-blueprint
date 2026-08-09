Installation Guide

To follow this course, you need the Terraform CLI installed on your machine.
🪟 Windows (Recommended: Winget, Chocolatey, Scoop or Manual)
Using Winget:
powershell

winget install --id HashiCorp.Terraform -e --source winget

Using Chocolatey:
powershell

choco install terraform -y

Using Scoop (No Admin Needed):
powershell

scoop bucket add main
scoop install terraform

Manual Install (If Package Managers Are Blocked):

    Download the zip from: https://releases.hashicorp.com/terraform/
    Extract to C:\terraform
    Add to PATH: Press Win Key -> Search "Edit the system environment variables" -> Environment Variables -> Path -> New -> C:\terraform
    Close and reopen your terminal/VS Code.

⚠️ Important Windows Setup for Docker:

Since we use a Local-First approach with Docker, please enable WSL2:

    Open PowerShell as Admin and run: wsl --install
    Restart your PC
    Open Docker Desktop -> Settings -> General -> Check "Use the WSL 2 based engine"
    Settings -> Resources -> WSL Integration -> Enable integration for your distro.

🍎 macOS (Using Homebrew)
bash

brew tap hashicorp/tap
brew install hashicorp/tap/terraform

🐧 Linux (Ubuntu/Debian)
bash

sudo apt-get update && sudo apt-get install -y gnupg software-properties-common curl
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
sudo apt-get install terraform -y

✅ Verify Installation

Open your terminal and run:
bash

terraform -version

You should see something like: Terraform v1.x.x

If you see terraform: command not found on Windows, close and reopen your terminal completely after adding to PATH.
🐳 Docker (Mandatory for Labs)

Since we are using a Local-First approach, please ensure Docker is installed and running.

Download Docker Desktop

After installing, verify with:
bash

docker --version
docker ps

Next: The Basic Workflow → [blocked]
