#!/bin/bash

# Colors
BLUE='\033[1;34m'
GREEN='\033[1;32m'
RED='\033[1;31m'
NC='\033[0m'

echo -e "${BLUE}🔹feat: installing Brave-Browser...${NC}"
sudo snap install brave
echo -e "${GREEN}chore: brave-browser installation completed ${NC}"

echo -e "${BLUE}🔹feat: installing Opera-Browser...${NC}"
sudo snap install opera
echo -e "${GREEN}chore: opera-browser installation completed ${NC}"

echo -e "${GREEN}chore: all browsers installed successfully! ${NC}"

