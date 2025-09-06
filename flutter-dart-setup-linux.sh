#!/bin/bash

# Colors
BLUE='\033[1;34m'
GREEN='\033[1;32m'
RED='\033[1;31m'
NC='\033[0m'

echo -e "${BLUE}🔹feat: installing flutter-SDK...${NC}"
sudo snap install flutter --classic
echo -e "${GREEN}chore: flutter-SDK installation completed ${NC}"

echo -e "${BLUE}🔹feat: adding Flutter-Dart to PATH...${NC}"
export PATH="$PATH:/snap/bin:/snap/flutter/common/flutter/bin"
export PATH="$PATH:/snap/flutter/common/flutter/bin/cache/dart-sdk/bin"
echo 'export PATH=$PATH:/snap/bin:/snap/flutter/common/flutter/bin' >> ~/.bashrc
echo 'export PATH=$PATH:/snap/flutter/common/flutter/bin/cache/dart-sdk/bin' >> ~/.bashrc
echo -e "${GREEN}chore: adding flutter and dart to PATH Success ${NC}"

echo -e "${GREEN}chore: flutter and dart setup completed successfully! ${NC}"
echo -e "${RED}fix: please restart your terminal or run 'source ~/.bashrc' to apply PATH changes.${NC}"

