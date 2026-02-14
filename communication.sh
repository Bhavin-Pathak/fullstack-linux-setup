#!/bin/bash
# Author: Bhavin Pathak
# Description: Communication & Messaging Apps

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

is_installed() {
    command -v "$1" &> /dev/null
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

check_and_ask() {
    local name="$1"
    local check_cmd="$2"
    local install_func="$3"
    local check_type="${4:-command}"

    local already_installed=false

    if [ "$check_type" == "dpkg" ]; then
        if dpkg -l | grep -q "$check_cmd"; then already_installed=true; fi
    elif [ "$check_type" == "snap" ]; then
        if snap list 2>/dev/null | grep -q "$check_cmd"; then already_installed=true; fi
    else 
        if is_installed "$check_cmd"; then already_installed=true; fi
    fi

    if [ "$already_installed" = true ]; then
        echo -e "${GREEN}✔ $name is already installed. Skipped.${NC}"
    else
        if ask_install "$name"; then
            $install_func
        fi
    fi
}

# --- Installers ---

install_slack() {
    print_msg "Installing Slack"
    sudo snap install slack
    echo -e "${GREEN}Slack Installed.${NC}"
}

install_discord() {
    print_msg "Installing Discord"
    sudo snap install discord
    echo -e "${GREEN}Discord Installed.${NC}"
}

install_zoom() {
    print_msg "Installing Zoom"
    wget https://zoom.us/client/latest/zoom_amd64.deb -O zoom.deb
    sudo apt install ./zoom.deb -y
    rm zoom.deb
    echo -e "${GREEN}Zoom Installed.${NC}"
}

install_teams() {
    print_msg "Installing Microsoft Teams"
    sudo snap install teams-for-linux
    echo -e "${GREEN}Teams Installed.${NC}"
}

# --- Main ---

clear
echo -e "${BLUE}${BOLD}Communication Apps${NC}"
echo -e "------------------------"

if ! is_installed snap; then
    print_msg "Installing Snapd (Required for most apps)"
    sudo apt update && sudo apt install snapd -y
fi

check_and_ask "Slack" "slack" install_slack "snap"
check_and_ask "Discord" "discord" install_discord "snap"
check_and_ask "Zoom" "zoom" install_zoom
check_and_ask "Microsoft Teams (Linux)" "teams-for-linux" install_teams "snap"

echo -e "\n${GREEN}Communication Setup Complete! 💬${NC}\n"
