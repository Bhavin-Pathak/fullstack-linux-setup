#!/bin/bash
set -e

# Colors
BLUE='\033[1;34m'
GREEN='\033[1;32m'
RED='\033[1;31m'
NC='\033[0m'

echo -e "${BLUE}🔹Ensuring snap is installed in system...${NC}"
sudo apt install snapd -y
echo -e "${GREEN}Snap is Installed successfully ${NC}"

echo -e "${BLUE}🔹Installing flutter-SDK...${NC}"
sudo snap install flutter --classic
echo -e "${GREEN}Flutter-SDK installation completed ${NC}"

echo -e "${BLUE}🔹Adding Flutter-Dart to PATH...${NC}"
export PATH="$PATH:/snap/bin:/snap/flutter/common/flutter/bin"
export PATH="$PATH:/snap/flutter/common/flutter/bin/cache/dart-sdk/bin"

echo 'export PATH=$PATH:/snap/bin:/snap/flutter/common/flutter/bin' >> ~/.bashrc
echo 'export PATH=$PATH:/snap/flutter/common/flutter/bin/cache/dart-sdk/bin' >> ~/.bashrc
echo -e "${GREEN}Adding flutter and Dart to PATH Success ${NC}"

echo -e "${BLUE}🔹Reloading bashrc to apply changes...${NC}"
source ~/.bashrc
echo -e "${GREEN}Reloading bashrc completed ${NC}"

echo -e "${BLUE}🔹Verifying Flutter and Dart installation...${NC}"
flutter --version
dart --version

echo -e "${GREEN}Flutter and Dart installed successfully! ${NC}"

