#!/bin/bash
set -e

# Colors
BLUE='\033[1;34m'
GREEN='\033[1;32m'
NC='\033[0m'

echo -e "${BLUE}🔹Ensuring snap is installed in system...${NC}"
sudo apt install snapd -y
echo -e "${GREEN}Snap is Installed successfully ${NC}"

echo -e "${BLUE}🔹Installing Android Studio...${NC}"
sudo snap install android-studio --classic
echo -e "${GREEN}Android-studio installation completed ${NC}"

echo -e "${BLUE}🔹Installing Visual Studio Code...${NC}"
sudo snap install code --classic
echo -e "${GREEN}Visual-studio-code installation completed ${NC}"

echo -e "${BLUE}🔹Installing Sublime-Text...${NC}"
sudo snap install sublime-text --classic
echo -e "${GREEN}Sublime-text installation completed ${NC}"

echo -e "${BLUE}🔹Installing Notepad++...${NC}"
sudo snap install notepad-plus-plus
echo -e "${GREEN}Notepad++ installation completed ${NC}"

echo -e "${BLUE}🔹Installing Postman For API Testing...${NC}"
sudo snap install postman
echo -e "${GREEN}Postman installation completed ${NC}"

echo -e "${BLUE}🔹Installing Beekeeper Studio For Database Viewer...${NC}"
sudo snap install beekeeper-studio
echo -e "${GREEN}Beekeeper-studio installation completed ${NC}"

echo -e "${BLUE}🔹Installing DBeaver-ce For Database Viewer...${NC}"
sudo snap install dbeaver-ce
echo -e "${GREEN}DBeaver-ce installation completed ${NC}"

echo -e "${GREEN}Development tools and Database viewer installed successfully! ${NC}"

