#!/bin/bash

# Colors
BLUE='\033[1;34m'
GREEN='\033[1;32m'
RED='\033[1;31m'
NC='\033[0m'

echo -e "${BLUE}🔹feat: ensuring snap is installed in system...${NC}"
sudo apt install snapd -y
echo -e "${GREEN}chore: snap is Installed successfully ${NC}"

echo -e "${BLUE}🔹feat: installing Android Studio...${NC}"
sudo snap install android-studio --classic
echo -e "${GREEN}chore: android-studio installation completed ${NC}"

echo -e "${BLUE}🔹feat: installing Visual Studio Code...${NC}"
sudo snap install code --classic
echo -e "${GREEN}chore: visual-studio-code installation completed ${NC}"

echo -e "${BLUE}🔹feat: installing Postman...${NC}"
sudo snap install postman
echo -e "${GREEN}chore: postman installation completed ${NC}"

echo -e "${BLUE}🔹feat: installing Beekeeper Studio For Database Viewer...${NC}"
sudo snap install beekeeper-studio
echo -e "${GREEN}chore: beekeeper-studio installation completed ${NC}"

echo -e "${GREEN}chore: all development tools installed successfully! ${NC}"

