#!/bin/bash
# Author: Bhavin Pathak
# Description: Quick setup for favorite Code Editors & IDEs

set -e

# Styling
BOLD='\033[1m'
BLUE='\033[1;34m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
RED='\033[1;31m'
NC='\033[0m'

# Helpers
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

install_vscode() {
    if is_installed code; then
        echo -e "${GREEN}VS Code is already installed.${NC}"
        return
    fi
    print_msg "Installing VS Code"
    sudo snap install code --classic
    echo -e "${GREEN}VS Code OK.${NC}"
}

install_cursor() {
    if is_installed cursor; then
        echo -e "${GREEN}Cursor is already installed.${NC}"
        return
    fi
    print_msg "Installing Cursor (AI Editor)"
    
    # Downloading specific .deb version
    wget -O cursor.deb "https://downloads.cursor.com/production/d2bf8ec12017b1049f304ad3a5c8867b117ed836/linux/x64/deb/amd64/deb/cursor_2.4.35_amd64.deb"
    
    sudo apt install ./cursor.deb -y
    rm cursor.deb
    echo -e "${GREEN}Cursor Installed.${NC}"
}

install_antigravity() {
    if is_installed antigravity; then
        echo -e "${GREEN}Antigravity is already installed.${NC}"
        return
    fi
    print_msg "Installing Antigravity IDE"
    
    # Repo Setup
    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://us-central1-apt.pkg.dev/doc/repo-signing-key.gpg | \
      sudo gpg --dearmor --yes -o /etc/apt/keyrings/antigravity-repo-key.gpg
    
    echo "deb [signed-by=/etc/apt/keyrings/antigravity-repo-key.gpg] https://us-central1-apt.pkg.dev/projects/antigravity-auto-updater-dev/ antigravity-debian main" | \
      sudo tee /etc/apt/sources.list.d/antigravity.list > /dev/null
    
    # Install
    sudo apt update && sudo apt install antigravity -y
    echo -e "${GREEN}Antigravity IDE OK.${NC}"
}

install_windsurf() {
    if is_installed windsurf; then
        echo -e "${GREEN}Windsurf is already installed.${NC}"
        return
    fi
    print_msg "Installing Windsurf (Codeium)"

    # GPG & Repo
    wget -qO- "https://windsurf-stable.codeiumdata.com/wVxQEIWkwPUEAGf3/windsurf.gpg" | gpg --dearmor > windsurf.gpg
    sudo install -D -o root -g root -m 644 windsurf.gpg /etc/apt/keyrings/windsurf.gpg
    echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/windsurf.gpg] https://windsurf-stable.codeiumdata.com/wVxQEIWkwPUEAGf3/apt stable main" | sudo tee /etc/apt/sources.list.d/windsurf.list > /dev/null
    rm windsurf.gpg

    sudo apt update && sudo apt install windsurf -y
    echo -e "${GREEN}Windsurf IDE OK.${NC}"
}

install_sublime() {
    if is_installed subl; then
        echo -e "${GREEN}Sublime Text is already installed.${NC}"
        return
    fi
    print_msg "Installing Sublime Text"
    sudo snap install sublime-text --classic
    echo -e "${GREEN}Sublime OK.${NC}"
}

install_notepadpp() {
    if is_installed notepad-plus-plus; then
        echo -e "${GREEN}Notepad++ is already installed.${NC}"
        return
    fi
    print_msg "Installing Notepad++"
    sudo snap install notepad-plus-plus
    echo -e "${GREEN}Notepad++ OK.${NC}"
}

# --- Main ---

clear
echo -e "${BLUE}${BOLD}IDE & Editor Setup${NC}"
echo -e "-------------------"

setup_snap

ask_install "VS Code" && install_vscode
ask_install "Cursor AI" && install_cursor
ask_install "Antigravity IDE" && install_antigravity
ask_install "Windsurf" && install_windsurf
ask_install "Sublime Text" && install_sublime
ask_install "Notepad++" && install_notepadpp

echo -e "\n${GREEN}Setup Complete! Happy Coding.${NC}\n"
