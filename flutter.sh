#!/bin/bash
# Author: Bhavin Pathak
# Description: Flutter, Dart, & Android Studio Setup with Smart Path Config

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

# --- Installers ---

setup_snap() {
    if ! is_installed snap; then
        print_msg "Installing Snapd"
        sudo apt update && sudo apt install snapd -y
    fi
}

install_flutter() {
    if is_installed flutter; then
        echo -e "${GREEN}Flutter is already installed.${NC}"
        # Still check path config
        configure_path
        return
    fi
    print_msg "Installing Flutter SDK"
    sudo snap install flutter --classic
    echo -e "${GREEN}Flutter SDK Installed.${NC}"
    
    configure_path
}

configure_path() {
    # Detect Shell
    local shell_config=""
    if [[ "$SHELL" == *"zsh"* ]]; then
        shell_config="$HOME/.zshrc"
        print_msg "Detected Zsh. Configuring $shell_config"
    elif [[ "$SHELL" == *"bash"* ]]; then
        shell_config="$HOME/.bashrc"
        print_msg "Detected Bash. Configuring $shell_config"
    else
        # Fallback or ask? Default to bashrc if unsure
        shell_config="$HOME/.bashrc"
        echo -e "${YELLOW}Unknown shell ($SHELL). Defaulting to $shell_config${NC}"
    fi

    # Check and Append
    if grep -q "snap/flutter/common/flutter/bin" "$shell_config"; then
        echo -e "${GREEN}Path already configured in $shell_config${NC}"
    else
        echo 'export PATH=$PATH:/snap/bin:/snap/flutter/common/flutter/bin' >> "$shell_config"
        echo 'export PATH=$PATH:/snap/flutter/common/flutter/bin/cache/dart-sdk/bin' >> "$shell_config"
        echo -e "${GREEN}Added Flutter/Dart to PATH in $shell_config${NC}"
        echo -e "${YELLOW}Run 'source $shell_config' or restart terminal to apply.${NC}"
    fi
}

install_android_studio() {
    if is_installed android-studio; then
        echo -e "${GREEN}Android Studio is already installed.${NC}"
        return
    fi
    print_msg "Installing Android Studio"
    sudo snap install android-studio --classic
    echo -e "${GREEN}Android Studio Installed.${NC}"
}

# --- Main ---

clear
echo -e "${BLUE}${BOLD}Flutter & Mobile Dev Setup${NC}"
echo -e "---------------------------"

setup_snap

ask_install "Flutter SDK + Dart" && install_flutter
ask_install "Android Studio" && install_android_studio

echo -e "\n${GREEN}Setup Complete! 📱${NC}"
echo -e "${YELLOW}Don't forget to run 'flutter doctor' after restarting your terminal.${NC}\n"
