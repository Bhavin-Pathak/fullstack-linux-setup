#!/bin/bash
# Author: Bhavin Pathak
# Description: Docker & Cloud DevOps Tools Installer

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

is_installed() {
    command -v "$1" &> /dev/null
}

ask_install() {
    local name=$1
    echo -e "${YELLOW}Install ${BOLD}$name${NC}${YELLOW}? [y/n]${NC}"
    read -p "> " choice
    case "$choice" in 
        [yY]*) return 0 ;;
        *) 
            echo -e "${RED}Skipped $name.${NC}"
            return 1 
            ;;
    esac
}

# --- Docker Installers ---

install_docker_engine() {
    if is_installed docker; then
        echo -e "${GREEN}Docker Engine is already installed.${NC}"
        # Check permissions
        if ! groups $USER | grep &>/dev/null "\bdocker\b"; then
             print_msg "Adding user to 'docker' group (Run without sudo)"
             sudo usermod -aG docker $USER
             echo -e "${YELLOW}Log out and back in for this to take effect.${NC}"
        fi
        return
    fi

    print_msg "Installing Docker Engine (CLI)"
    
    # Prereqs
    sudo apt update
    sudo apt install -y ca-certificates curl gnupg lsb-release

    # GPG Key
    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    sudo chmod a+r /etc/apt/keyrings/docker.gpg

    # Repository
    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
      $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    
    # Install
    sudo apt update
    sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

    # Post-install steps
    print_msg "Configuring user permissions"
    sudo usermod -aG docker $USER
    
    echo -e "${GREEN}Docker Engine Installed.${NC}"
    echo -e "${YELLOW}⚠️  Please log out/in to use 'docker' without sudo.${NC}"
}

install_docker_desktop() {
    # Docker Desktop check is tricky as it's a GUI app, usually located in /opt/docker-desktop
    if [ -d "/opt/docker-desktop" ]; then
        echo -e "${GREEN}Docker Desktop is already installed.${NC}"
        return
    fi
    
    print_msg "Installing Docker Desktop (GUI)"
    
    # 1. Install KVM/QEMU dependencies (Required for Desktop)
    print_msg "Setting up KVM dependencies"
    sudo apt install -y qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils virtinst virt-manager
    sudo adduser $USER libvirt
    sudo adduser $USER kvm

    # 2. Download .deb (Link provided by user)
    print_msg "Downloading Docker Desktop .deb..."
    wget -O docker-desktop.deb "https://desktop.docker.com/linux/main/amd64/docker-desktop-amd64.deb?utm_source=docker&utm_medium=webreferral&utm_campaign=docs-driven-download-linux-amd64"
    
    # 3. Install
    print_msg "Installing Package (This may take a moment)..."
    sudo apt update
    sudo apt install ./docker-desktop.deb -y
    
    rm docker-desktop.deb
    echo -e "${GREEN}Docker Desktop Installed! Launch it from your applications menu.${NC}"
}

# --- Cloud Tools Installers ---

install_aws() {
    print_msg "Installing AWS CLI"
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    unzip awscliv2.zip
    sudo ./aws/install --update
    rm -rf aws awscliv2.zip
    echo -e "${GREEN}AWS CLI Installed: $(aws --version)${NC}"
}

install_terraform() {
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
}

install_kubectl() {
    print_msg "Installing Kubectl"
    sudo apt-get update && sudo apt-get install -y apt-transport-https ca-certificates curl gnupg
    curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.29/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg --yes
    echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.29/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
    sudo apt-get update
    sudo apt-get install -y kubectl
    echo -e "${GREEN}Kubectl Installed${NC}"
}

install_ansible() {
    print_msg "Installing Ansible"
    sudo add-apt-repository --yes --update ppa:ansible/ansible
    sudo apt install -y ansible
    echo -e "${GREEN}Ansible Installed: $(ansible --version | head -n 1)${NC}"
}

install_azure() {
    print_msg "Installing Azure CLI"
    curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
    echo -e "${GREEN}Azure CLI Installed${NC}"
}

# --- Main ---

clear
echo -e "${BLUE}${BOLD}Docker & Cloud DevOps Setup${NC}"
echo -e "-----------------------------"

ask_install "Docker Engine (Server/CLI)" && install_docker_engine
ask_install "Docker Desktop (GUI App)" && install_docker_desktop

echo -e "\n${YELLOW}--- Cloud Tools ---${NC}\n"

ask_install "AWS CLI v2" && install_aws
ask_install "Terraform" && install_terraform
ask_install "Kubectl (Kubernetes CLI)" && install_kubectl
ask_install "Ansible" && install_ansible
ask_install "Azure CLI" && install_azure

echo -e "\n${GREEN}Setup Complete! ☁️ 🐳${NC}\n"
