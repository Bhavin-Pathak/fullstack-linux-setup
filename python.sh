#!/bin/bash
# Author: Bhavin Pathak
# Description: Python 3, Pip & Venv Setup

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

# --- Detection ---

get_shell_rc() {
    if [[ "$SHELL" == *"zsh"* ]]; then
        echo "$HOME/.zshrc"
    elif [[ "$SHELL" == *"bash"* ]]; then
        echo "$HOME/.bashrc"
    else
        echo "$HOME/.bashrc"
    fi
}

# --- Installers ---

install_python_stack() {
    print_msg "Updating Package List"
    sudo apt update

    print_msg "Installing Python 3 & Tools"
    sudo apt install -y python3 python3-pip python3-venv python3-dev build-essential

    print_msg "Setting Alternatives (python -> python3)"
    sudo update-alternatives --install /usr/bin/python python /usr/bin/python3 1 || true
    sudo update-alternatives --install /usr/bin/pip pip /usr/bin/pip3 1 || true

    # Smart Config
    local rc_file=$(get_shell_rc)
    print_msg "Configuring Shell: $rc_file"

    local user_bin='export PATH=$PATH:~/.local/bin'
    
    if grep -q "PATH.*.local/bin" "$rc_file"; then
        echo -e "${GREEN}PATH already configured in $rc_file${NC}"
    else
        echo "" >> "$rc_file"
        echo "# Python Local Bin" >> "$rc_file"
        echo "$user_bin" >> "$rc_file"
        echo -e "${GREEN}Added ~/.local/bin to PATH in $rc_file${NC}"
    fi

    echo -e "${YELLOW}Run 'source $rc_file' to apply changes.${NC}"
}

# --- Main ---

clear
echo -e "${BLUE}${BOLD}Python Development Setup${NC}"
echo -e "------------------------"

install_python_stack

echo -e "\n${GREEN}Setup Complete! 🐍${NC}"
echo -e "Python: $(python --version)"
echo -e "Pip:    $(pip --version)"
echo -e "\n"
