#!/bin/bash
set -e

# Colors
BLUE='\033[1;34m'
GREEN='\033[1;32m'
RED='\033[1;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}🔹Updating system and installing dependencies...${NC}"
sudo apt-get update -y
sudo apt-get install -y ca-certificates curl gnupg lsb-release
echo -e "${GREEN}Dependencies installed completed ${NC}"

echo -e "${BLUE}🔹Setting-up Docker's official GPG key...${NC}"
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo tee /etc/apt/keyrings/docker.asc > /dev/null
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo -e "${GREEN}Setting-up GPG-KEY is completed ${NC}"

echo -e "${BLUE}🔹Adding Docker-repository...${NC}"
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update -y
echo -e "${GREEN}Repository added successfully ${NC}"

echo -e "${BLUE}🔹Installing Docker-Engine and related tools...${NC}"
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
echo -e "${GREEN}Docker-engine and related Tools are successfully installed ${NC}"

echo -e "${BLUE}Docker installation complete!${NC}"

# Final Note
echo -e "${RED}Docker-Desktop is not installed by this script.${NC}"
echo -e "${RED}Please download it manually from: https://docs.docker.com/desktop/setup/install/linux/ubuntu/${NC}"

