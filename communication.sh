#!/bin/bash
# Author: Bhavin Pathak
# Description: Communication & Team Apps Installer

set -e

# Styling
BOLD='\033[1m'
BLUE='\033[1;34m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
RED='\033[1;31m'
NC='\033[0m'

print_msg() {
    echo -e "\n${BLUE}${BOLD}>>> $1...${NC}\n"
}

ask_install() {
    local name=$1
    echo -e "${YELLOW}Install ${BOLD}$name${NC}${YELLOW}? [y/n]${NC}"
    read -p "> " choice
    case "$choice" in 
        [yY]*) return 0 ;;
        *) 
            echo -e "${RED}Skipped $name.${NC}"
            return 1 
            ;;
    esac
}

print_msg "Communication Apps"

if ask_install "Slack"; then
    sudo snap install slack
fi

if ask_install "Discord"; then
    sudo snap install discord
fi

if ask_install "Zoom"; then
    sudo snap install zoom-client
fi

if ask_install "Microsoft Teams"; then
    sudo snap install teams-for-linux
fi

echo -e "\n${GREEN}Communication Tools Installed! 💬${NC}\n"
