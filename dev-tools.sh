#!/bin/bash

# Colors
BLUE='\033[1;34m'
GREEN='\033[1;32m'
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

echo -e "${BLUE}🔹feat: installing Sublime-Text...${NC}"
sudo snap install sublime-text --classic
echo -e "${GREEN}chore: sublime-text installation completed ${NC}"

echo -e "${BLUE}🔹feat: installing Notepad++...${NC}"
sudo snap install notepad-plus-plus
echo -e "${GREEN}chore: Notepad++ installation completed ${NC}"

echo -e "${BLUE}🔹feat: installing Postman For API Testing...${NC}"
sudo snap install postman
echo -e "${GREEN}chore: postman installation completed ${NC}"

echo -e "${BLUE}🔹feat: installing Beekeeper Studio For Database Viewer...${NC}"
sudo snap install beekeeper-studio
echo -e "${GREEN}chore: beekeeper-studio installation completed ${NC}"

echo -e "${GREEN}chore: Development tools installed successfully! ${NC}"

