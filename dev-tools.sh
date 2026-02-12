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
    
    # Official direct download link for Linux .deb (x64) provided by user
    # Note: This link might be version-specific.
    wget -O cursor.deb "https://downloads.cursor.com/production/d2bf8ec12017b1049f304ad3a5c8867b117ed836/linux/x64/deb/amd64/deb/cursor_2.4.35_amd64.deb"
    
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
    if check_cmd antigravity; then
        echo -e "${GREEN}Antigravity is already installed.${NC}"
        return
    fi
    print_header "Installing Antigravity IDE"
    
    # 1. Create keyrings directory
    sudo mkdir -p /etc/apt/keyrings
    
    # 2. Add GPG Key
    print_header "Adding Antigravity GPG Key..."
    curl -fsSL https://us-central1-apt.pkg.dev/doc/repo-signing-key.gpg | \
      sudo gpg --dearmor --yes -o /etc/apt/keyrings/antigravity-repo-key.gpg
    
    # 3. Add Repository
    print_header "Adding Antigravity Repository..."
    echo "deb [signed-by=/etc/apt/keyrings/antigravity-repo-key.gpg] https://us-central1-apt.pkg.dev/projects/antigravity-auto-updater-dev/ antigravity-debian main" | \
      sudo tee /etc/apt/sources.list.d/antigravity.list > /dev/null
    
    # 4. Update and Install
    print_header "Updating apt and installing..."
    sudo apt update
    sudo apt install antigravity -y
    
    echo -e "${GREEN}Antigravity IDE installed successfully.${NC}"
}

install_windsurf() {
    if check_cmd windsurf; then
        echo -e "${GREEN}Windsurf is already installed.${NC}"
        return
    fi
    print_header "Installing Windsurf (Codeium AI IDE)"
    
    # Logic merged from windsurf-ide-setup.sh
    sudo apt-get install wget gpg -y
    wget -qO- "https://windsurf-stable.codeiumdata.com/wVxQEIWkwPUEAGf3/windsurf.gpg" | gpg --dearmor > windsurf-stable.gpg
    sudo install -D -o root -g root -m 644 windsurf-stable.gpg /etc/apt/keyrings/windsurf-stable.gpg
    echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/windsurf-stable.gpg] https://windsurf-stable.codeiumdata.com/wVxQEIWkwPUEAGf3/apt stable main" | sudo tee /etc/apt/sources.list.d/windsurf.list > /dev/null
    rm -f windsurf-stable.gpg
    sudo apt install apt-transport-https -y
    sudo apt update
    sudo apt install windsurf -y
    
    echo -e "${GREEN}Windsurf IDE installed successfully.${NC}"
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

if confirm_install "Antigravity IDE (Internal/Beta)"; then
    install_antigravity
else
    echo -e "${RED}Skipped Antigravity.${NC}"
fi

if confirm_install "Windsurf (Codeium)"; then
    install_windsurf
else
    echo -e "${RED}Skipped Windsurf.${NC}"
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
