#!/bin/bash
# Author: Bhavin Pathak
# Description: Cloud & DevOps Tools Installer

set -e

# Styling
BOLD='\033[1m'
BLUE='\033[1;34m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
RED='\033[1;31m'
NC='\033[0m'

print_msg() {
    echo -e "\n${BLUE}${BOLD}>>> $1...${NC}\n"
}

ask_install() {
    local name=$1
    echo -e "${YELLOW}Install ${BOLD}$name${NC}${YELLOW}? [y/n]${NC}"
    read -p "> " choice
    case "$choice" in 
        [yY]*) return 0 ;;
        *) return 1 ;;
    esac
}

# ==========================================
# 1. AWS CLI
# ==========================================
if ask_install "AWS CLI v2"; then
    print_msg "Installing AWS CLI"
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    unzip awscliv2.zip
    sudo ./aws/install --update
    rm -rf aws awscliv2.zip
    echo -e "${GREEN}AWS CLI Installed: $(aws --version)${NC}"
fi

# ==========================================
# 2. Terraform
# ==========================================
if ask_install "Terraform"; then
    print_msg "Installing Terraform"
    sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
    wget -O- https://apt.releases.hashicorp.com/gpg | \
        gpg --dearmor | \
        sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null
    gpg --no-default-keyring \
        --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
        --fingerprint
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
        https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
        sudo tee /etc/apt/sources.list.d/hashicorp.list
    sudo apt update
    sudo apt install -y terraform
    echo -e "${GREEN}Terraform Installed: $(terraform -version)${NC}"
fi

# ==========================================
# 3. Kubectl
# ==========================================
if ask_install "Kubectl (Kubernetes CLI)"; then
    print_msg "Installing Kubectl"
    sudo apt-get update && sudo apt-get install -y apt-transport-https ca-certificates curl gnupg
    curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.29/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg --yes
    echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.29/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
    sudo apt-get update
    sudo apt-get install -y kubectl
    echo -e "${GREEN}Kubectl Installed${NC}"
fi

# ==========================================
# 4. Ansible
# ==========================================
if ask_install "Ansible"; then
    print_msg "Installing Ansible"
    sudo add-apt-repository --yes --update ppa:ansible/ansible
    sudo apt install -y ansible
    echo -e "${GREEN}Ansible Installed: $(ansible --version | head -n 1)${NC}"
fi

# ==========================================
# 5. Azure CLI
# ==========================================
if ask_install "Azure CLI"; then
    print_msg "Installing Azure CLI"
    curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
    echo -e "${GREEN}Azure CLI Installed${NC}"
fi

echo -e "\n${GREEN}Cloud Tools Setup Complete! ☁️${NC}\n"
