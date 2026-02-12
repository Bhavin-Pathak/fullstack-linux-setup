#!/bin/bash
# Author: Bhavin Pathak
# Description: Database Viewers & Management Tools Installer

set -e

# Terminal Colors
BOLD='\033[1m'
BLUE='\033[1;34m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
RED='\033[1;31m'
NC='\033[0m'

print_header() {
    echo -e "\n${BLUE}${BOLD}>>> $1...${NC}\n"
}

check_cmd() {
    command -v "$1" &> /dev/null
}

confirm_install() {
    local tool=$1
    echo -e "${YELLOW}Do you want to install ${BOLD}$tool${NC}${YELLOW}?${NC}"
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
    fi
}

install_dbeaver() {
    if check_cmd dbeaver-ce; then
        echo -e "${GREEN}DBeaver is already installed.${NC}"
        return
    fi
    print_header "Installing DBeaver Community"
    sudo snap install dbeaver-ce
    echo -e "${GREEN}DBeaver installed.${NC}"
}

install_compass() {
    if check_cmd mongodb-compass; then
        echo -e "${GREEN}MongoDB Compass is already installed.${NC}"
        return
    fi
    print_header "Installing MongoDB Compass"
    # Download .deb because Snap version is often unofficial or outdated
    wget https://downloads.mongodb.com/compass/mongodb-compass_1.40.4_amd64.deb -O compass.deb
    sudo apt install ./compass.deb -y
    rm compass.deb
    echo -e "${GREEN}MongoDB Compass installed.${NC}"
}

install_beekeeper() {
    if check_cmd beekeeper-studio; then
        echo -e "${GREEN}Beekeeper Studio is already installed.${NC}"
        return
    fi
    print_header "Installing Beekeeper Studio"
    sudo snap install beekeeper-studio
    echo -e "${GREEN}Beekeeper Studio installed.${NC}"
}

install_postman() {
     if check_cmd postman; then
        echo -e "${GREEN}Postman is already installed.${NC}"
        return
    fi
    print_header "Installing Postman (API Tool)"
    sudo snap install postman
    echo -e "${GREEN}Postman installed.${NC}"
}


# --- Main ---

clear
echo -e "${BLUE}${BOLD}Database Tools Setup${NC}"
echo -e "---------------------------------"

ensure_snap

if confirm_install "DBeaver (Universal DB Tool)"; then
    install_dbeaver
else
    echo -e "${RED}Skipped DBeaver.${NC}"
fi

if confirm_install "MongoDB Compass"; then
    install_compass
else
    echo -e "${RED}Skipped Compass.${NC}"
fi

if confirm_install "Beekeeper Studio (Modern UI)"; then
    install_beekeeper
else
    echo -e "${RED}Skipped Beekeeper.${NC}"
fi

if confirm_install "Postman (API Testing)"; then
    install_postman
else
    echo -e "${RED}Skipped Postman.${NC}"
fi

echo -e "\n${GREEN}${BOLD}Database Tools Ready! 🗄️${NC}\n"
