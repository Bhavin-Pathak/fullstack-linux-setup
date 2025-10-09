#!/bin/bash
set -e

# Colors
BLUE='\033[1;34m'
GREEN='\033[1;32m'
RED='\033[1;31m'
NC='\033[0m' 

echo -e "${BLUE}🔹Updating system packages...${NC}"
sudo apt-get update -y && sudo apt-get upgrade -y
echo -e "${GREEN}System packages updated successfully ${NC}"

echo -e "${BLUE}🔹Installing Python, pip, and dependencies...${NC}"
sudo apt-get install -y python3 python3-pip python3-venv python3-dev build-essential
echo -e "${GREEN}Python and pip installed successfully ${NC}"

echo -e "${BLUE}🔹Setting Python alternatives...${NC}"
sudo update-alternatives --install /usr/bin/python python /usr/bin/python3 1
sudo update-alternatives --install /usr/bin/pip pip /usr/bin/pip3 1
echo -e "${GREEN}Python → python3 & pip → pip3 set successfully ${NC}"

echo -e "${BLUE}🔹Adding ~/.local/bin to PATH...${NC}"
if ! grep -q "export PATH=\$PATH:~/.local/bin" ~/.bashrc; then
  echo 'export PATH=$PATH:~/.local/bin' >> ~/.bashrc
  echo -e "${GREEN}PATH updated in ~/.bashrc ${NC}"
else
  echo -e "${GREEN}PATH already configured ${NC}"
fi

echo -e "${BLUE}🔹Reloading bashrc...${NC}"
source ~/.bashrc
echo -e "${GREEN}bashrc reloaded ${NC}"

echo -e "${BLUE}🔹Verifying installation Versions...${NC}"
echo -e "${GREEN}Python version: $(python --version) ${NC}"
echo -e "${GREEN}pip version: $(pip --version) ${NC}"
echo -e "${GREEN}Successfully completed the setup!${NC}"
