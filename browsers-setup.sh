#!/bin/bash

# Colors
BLUE='\033[1;34m'
GREEN='\033[1;32m'
NC='\033[0m'

echo -e "${BLUE}🔹feat: ensuring snap is installed in system...${NC}"
sudo apt install snapd -y
echo -e "${GREEN}chore: snap is Installed successfully ${NC}"

echo -e "${BLUE}🔹feat: installing Brave-Browser...${NC}"
sudo snap install brave
echo -e "${GREEN}chore: brave-browser installation completed ${NC}"

echo -e "${BLUE}🔹feat: installing Opera-Browser...${NC}"
sudo snap install opera
echo -e "${GREEN}chore: opera-browser installation completed ${NC}"

echo -e "${BLUE}🔹feat: installing Chromium-Browser...${NC}"
sudo snap install chromium
echo -e "${GREEN}chore: chromium installation completed ${NC}"

echo -e "${BLUE}🔹feat: installing Firefox-Browser...${NC}"
sudo snap install firefox
echo -e "${GREEN}chore: firefox installation completed ${NC}"

echo -e "${GREEN}chore: Browsers installed successfully! ${NC}"

