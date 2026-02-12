#!/bin/bash
# Author: Bhavin Pathak
# Description: Database GUIs & Viewers Setup

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
        *) return 1 ;;
    esac
}

# --- Installers ---

setup_snap() {
    if ! is_installed snap; then
        print_msg "Installing Snapd"
        sudo apt update && sudo apt install snapd -y
    fi
}

install_dbeaver() {
    if is_installed dbeaver-ce; then
        echo -e "${GREEN}DBeaver is already installed.${NC}"
        return
    fi
    print_msg "Installing DBeaver CE"
    sudo snap install dbeaver-ce
    echo -e "${GREEN}DBeaver Installed.${NC}"
}

install_compass() {
    if is_installed mongodb-compass; then
        echo -e "${GREEN}MongoDB Compass is already installed.${NC}"
        return
    fi
    print_msg "Installing MongoDB Compass"
    # Downloading .deb for official support (Snap often buggy for Compass)
    wget https://downloads.mongodb.com/compass/mongodb-compass_1.40.4_amd64.deb -O compass.deb
    sudo apt install ./compass.deb -y
    rm compass.deb
    echo -e "${GREEN}Compass Installed.${NC}"
}

install_beekeeper() {
    if is_installed beekeeper-studio; then
        echo -e "${GREEN}Beekeeper Studio is already installed.${NC}"
        return
    fi
    print_msg "Installing Beekeeper Studio"
    sudo snap install beekeeper-studio
    echo -e "${GREEN}Beekeeper Installed.${NC}"
}

install_racompass() {
    if is_installed racompass; then
        echo -e "${GREEN}Racompass is already installed.${NC}"
        return
    fi
    print_msg "Installing Racompass (Redis GUI)"
    sudo snap install racompass
    echo -e "${GREEN}Racompass Installed.${NC}"
}

# --- Main ---

clear
echo -e "${BLUE}${BOLD}Database Viewers Setup${NC}"
echo -e "-----------------------"

setup_snap

ask_install "DBeaver (Universal)" && install_dbeaver
ask_install "pgAdmin4 (PostgreSQL)" && install_pgadmin
ask_install "MongoDB Compass" && install_compass
ask_install "Beekeeper Studio" && install_beekeeper
ask_install "Racompass (Redis)" && install_racompass

echo -e "\n${GREEN}DB Tools Ready! 🗄️${NC}\n"
