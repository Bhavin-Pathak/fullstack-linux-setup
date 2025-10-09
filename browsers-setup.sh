#!/bin/bash
set -e

# Colors
BLUE='\033[1;34m'
GREEN='\033[1;32m'
NC='\033[0m'

echo -e "${BLUE}🔹Ensuring snap is installed in system...${NC}"
sudo apt install snapd -y
echo -e "${GREEN}Snap is Installed successfully ${NC}"

echo -e "${BLUE}🔹Installing Brave-Browser...${NC}"
sudo snap install brave
echo -e "Brave Version is : $(brave --version)"
echo -e "${GREEN}Brave-browser installation completed ${NC}"

echo -e "${BLUE}🔹Installing Opera-Browser...${NC}"
sudo snap install opera
echo -e "Opera Version is : $(opera --version)"
echo -e "${GREEN}Opera-browser installation completed ${NC}"

echo -e "${BLUE}🔹Installing Chromium-Browser...${NC}"
sudo snap install chromium
echo -e "Chromium Version is : $(chromium --version)"
echo -e "${GREEN}Chromium installation completed ${NC}"

echo -e "${BLUE}🔹Installing Firefox-Browser...${NC}"
sudo snap install firefox
echo -e "Firefox Version is : $(firefox --version)"
echo -e "${GREEN}Firefox installation completed ${NC}"

echo -e "${GREEN}All Browsers installed successfully! ${NC}"

