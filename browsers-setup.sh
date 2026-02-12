#!/bin/bash
# Author: Bhavin Pathak
# Description: Automated Browser Installation Script with Menu

set -e

# Terminal Colors
BOLD='\033[1m'
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
CYAN='\033[1;36m'
NC='\033[0m'

# Check command availability
check_cmd() {
    command -v "$1" &> /dev/null
}

# Section Header
print_header() {
    echo -e "\n${BLUE}${BOLD}>>> $1...${NC}\n"
}

# User confirmation prompt
confirm_install() {
    local browser=$1
    echo -e "${YELLOW}Do you want to install ${BOLD}$browser${NC}${YELLOW}?${NC}"
    read -p "Type [y/n]: " choice
    case "$choice" in 
        [yY][eE][sS]|[yY]) return 0 ;;
        *) return 1 ;;
    esac
}

# --- Installation Steps ---

ensure_snap() {
    if ! check_cmd snap; then
        print_header "Installing Snapd"
        sudo apt update && sudo apt install snapd -y
        echo -e "${GREEN}Snapd installed.${NC}"
    fi
}

install_chrome() {
    if check_cmd google-chrome; then
        echo -e "${GREEN}Chrome is already installed.${NC}"
        return
    fi

    print_header "Installing Google Chrome"
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O chrome.deb
    sudo apt install ./chrome.deb -y
    rm chrome.deb
    echo -e "${GREEN}Chrome installed successfully.${NC}"
}

install_browser_snap() {
    local name=$1
    local pkg=$2

    if check_cmd "$pkg"; then
        echo -e "${GREEN}$name is already installed.${NC}"
        return
    fi

    print_header "Installing $name"
    sudo snap install "$pkg"
    echo -e "${GREEN}$name installed successfully.${NC}"
}

# --- Main ---

clear
echo -e "${CYAN}${BOLD}Browser Setup Wizard${NC}"
echo -e "---------------------------------"

ensure_snap

# Browser List
if confirm_install "Google Chrome"; then
    install_chrome
else
    echo -e "${RED}Skipped Chrome.${NC}"
fi

if confirm_install "Brave Browser"; then
    install_browser_snap "Brave" "brave"
else
    echo -e "${RED}Skipped Brave.${NC}"
fi

if confirm_install "Firefox"; then
    install_browser_snap "Firefox" "firefox"
else
    echo -e "${RED}Skipped Firefox.${NC}"
fi

if confirm_install "Opera"; then
    install_browser_snap "Opera" "opera"
else
    echo -e "${RED}Skipped Opera.${NC}"
fi

if confirm_install "Chromium"; then
    install_browser_snap "Chromium" "chromium"
else
    echo -e "${RED}Skipped Chromium.${NC}"
fi

echo -e "\n${GREEN}${BOLD}All Done! Happy Surfing 🌐${NC}\n"
