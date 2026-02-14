#!/bin/bash
# Author: Bhavin Pathak
# Description: Essential System Utilities

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
    # Optional 4th arg: check_type (command, dpkg, snap)
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

install_flameshot() {
    print_msg "Installing Flameshot (Screenshot Tool)"
    sudo apt install flameshot -y
    echo -e "${GREEN}Flameshot Installed.${NC}"
}

install_gparted() {
    print_msg "Installing GParted"
    sudo apt install gparted -y
    echo -e "${GREEN}GParted Installed.${NC}"
}

install_btop() {
    print_msg "Installing Btop (Monitor)"
    sudo apt install btop -y
    echo -e "${GREEN}Btop Installed.${NC}"
}

install_peek() {
    print_msg "Installing Peek (GIF Recorder)"
    sudo add-apt-repository ppa:peek-developers/stable -y
    sudo apt update
    sudo apt install peek -y
    echo -e "${GREEN}Peek Installed.${NC}"
}

# --- Main ---

clear
echo -e "${BLUE}${BOLD}Utilities Setup${NC}"
echo -e "------------------------"

check_and_ask "Flameshot" "flameshot" install_flameshot
check_and_ask "GParted" "gparted" install_gparted
check_and_ask "Btop" "btop" install_btop
check_and_ask "Peek" "peek" install_peek

echo -e "\n${GREEN}Utilities Setup Complete! 🛠️${NC}\n"
