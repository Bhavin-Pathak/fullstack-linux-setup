#!/bin/bash
# Author: Bhavin Pathak
# Description: Media & Entertainment Apps

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

install_spotify() {
    print_msg "Installing Spotify"
    sudo snap install spotify
    echo -e "${GREEN}Spotify Installed.${NC}"
}

install_vlc() {
    print_msg "Installing VLC Media Player"
    sudo apt install vlc -y
    echo -e "${GREEN}VLC Installed.${NC}"
}

install_obs() {
    print_msg "Installing OBS Studio"
    sudo add-apt-repository ppa:obsproject/obs-studio -y
    sudo apt update
    sudo apt install obs-studio -y
    echo -e "${GREEN}OBS Installed.${NC}"
}

install_audacity() {
    print_msg "Installing Audacity"
    sudo snap install audacity
    echo -e "${GREEN}Audacity Installed.${NC}"
}

# --- Main ---

clear
echo -e "${BLUE}${BOLD}Media & Entertainment${NC}"
echo -e "------------------------"

if ! is_installed snap; then
    print_msg "Installing Snapd"
    sudo apt update && sudo apt install snapd -y
fi

check_and_ask "Spotify" "spotify" install_spotify "snap"
check_and_ask "VLC Media Player" "vlc" install_vlc
check_and_ask "OBS Studio" "obs" install_obs
check_and_ask "Audacity" "audacity" install_audacity "snap"

echo -e "\n${GREEN}Media Setup Complete! 🎬${NC}\n"
