#!/bin/bash
# Author: Bhavin Pathak
# Description: System Utility Apps Installer

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
        *) return 1 ;;
    esac
}

print_msg "Utility Apps"

if ask_install "Flameshot (Screenshots)"; then
    sudo apt install -y flameshot
fi

if ask_install "GParted (Disk Management)"; then
    sudo apt install -y gparted
fi

echo -e "\n${GREEN}Utilities Installed! 🛠️${NC}\n"
