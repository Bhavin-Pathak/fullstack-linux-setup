#!/bin/bash
# Author: Bhavin Pathak
# Description: Ultimate Development Editors & IDEs Installer

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

install_vscode() {
    if check_cmd code; then
        echo -e "${GREEN}VS Code is already installed.${NC}"
        return
    fi
    print_header "Installing Visual Studio Code"
    sudo snap install code --classic
    echo -e "${GREEN}VS Code installed successfully.${NC}"
}

install_cursor() {
    if check_cmd cursor; then
        echo -e "${GREEN}Cursor is already installed.${NC}"
        return
    fi

    print_header "Installing Cursor AI Editor (.deb)"
    echo -e "${BLUE}Downloading Cursor .deb package...${NC}"
    
    # Official direct download link for Linux .deb (x64)
    wget -O cursor.deb "https://downloader.cursor.sh/linux/debian/x64"
    
    echo -e "${BLUE}Installing Cursor...${NC}"
    # This will install and also trigger the repo addition prompt if applicable
    sudo apt install ./cursor.deb -y
    
    rm cursor.deb
    echo -e "${GREEN}Cursor installed successfully.${NC}"
}

install_sublime() {
    if check_cmd subl; then
        echo -e "${GREEN}Sublime Text is already installed.${NC}"
        return
    fi
    print_header "Installing Sublime Text"
    sudo snap install sublime-text --classic
    echo -e "${GREEN}Sublime Text installed.${NC}"
}

install_notepadpp() {
    if check_cmd notepad-plus-plus; then
        echo -e "${GREEN}Notepad++ is already installed.${NC}"
        return
    fi
    print_header "Installing Notepad++ (Wine)"
    sudo snap install notepad-plus-plus
    echo -e "${GREEN}Notepad++ installed.${NC}"
}

install_antigravity() {
    # Placeholder for "Antigravity" IDE if it exists, or maybe user meant general AI tools?
    # Assuming user might have meant a specific tool or just a fun name. 
    # Skipping for now unless a real package exists.
    echo -e "${RED}Antigravity IDE package not found/supported yet.${NC}"
}

# --- Main ---

clear
echo -e "${BLUE}${BOLD}Code Editors & IDE Setup Wizard${NC}"
echo -e "------------------------------------"

ensure_snap

if confirm_install "Visual Studio Code"; then
    install_vscode
else
    echo -e "${RED}Skipped VS Code.${NC}"
fi

if confirm_install "Cursor AI Editor"; then
    install_cursor
else
    echo -e "${RED}Skipped Cursor.${NC}"
fi

if confirm_install "Sublime Text"; then
    install_sublime
else
    echo -e "${RED}Skipped Sublime Text.${NC}"
fi

if confirm_install "Notepad++"; then
    install_notepadpp
else
    echo -e "${RED}Skipped Notepad++.${NC}"
fi

echo -e "\n${GREEN}${BOLD}IDE Setup Completed! Happy Coding 🚀${NC}\n"
