#!/bin/bash

BLUE='\033[1;34m'
GREEN='\033[1;32m'
RED='\033[1;31m'
NC='\033[0m' 

echo -e "${BLUE}🔹feat: updating system packages...${NC}"
sudo apt-get update -y && sudo apt-get upgrade -y
echo -e "${GREEN}chore: system packages updated successfully ${NC}"

echo -e "${BLUE}🔹feat: installing Python, pip, and dependencies...${NC}"
sudo apt-get install -y python3 python3-pip python3-venv python3-dev build-essential
echo -e "${GREEN}chore: Python and pip installed successfully ${NC}"

echo -e "${BLUE}🔹feat: setting Python alternatives...${NC}"
sudo update-alternatives --install /usr/bin/python python /usr/bin/python3 1
sudo update-alternatives --install /usr/bin/pip pip /usr/bin/pip3 1
echo -e "${GREEN}chore: python → python3 & pip → pip3 set successfully ${NC}"

echo -e "${BLUE}🔹feat: adding ~/.local/bin to PATH...${NC}"
if ! grep -q "export PATH=\$PATH:~/.local/bin" ~/.bashrc; then
  echo 'export PATH=$PATH:~/.local/bin' >> ~/.bashrc
  echo -e "${GREEN}chore: PATH updated in ~/.bashrc ${NC}"
else
  echo -e "${GREEN}chore: PATH already configured ${NC}"
fi

echo -e "${BLUE}🔹feat: reloading bashrc...${NC}"
source ~/.bashrc
echo -e "${GREEN}chore: bashrc reloaded ${NC}"

echo -e "${BLUE}🔹feat: verifying installation...${NC}"
python --version && pip --version
