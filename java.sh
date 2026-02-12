#!/bin/bash
# Author: Bhavin Pathak
# Description: Java 17 LTS Setup & Path Configuration

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

# --- Installers ---

install_java() {
    if is_installed java; then
        echo -e "${GREEN}Java is already installed: $(java -version 2>&1 | head -n 1)${NC}"
        # Still check path config
        configure_path
        return
    fi

    print_msg "Updating Package List"
    sudo apt update

    print_msg "Installing OpenJDK 17"
    sudo apt install -y openjdk-17-jdk
    echo -e "${GREEN}Java Installed.${NC}"

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
        shell_config="$HOME/.bashrc"
        echo -e "${YELLOW}Unknown shell ($SHELL). Defaulting to $shell_config${NC}"
    fi

    local java_path="/usr/lib/jvm/java-17-openjdk-amd64"

    # Check and Append
    if grep -q "JAVA_HOME.*$java_path" "$shell_config"; then
        echo -e "${GREEN}JAVA_HOME already set in $shell_config${NC}"
    else
        echo "" >> "$shell_config"
        echo "export JAVA_HOME=$java_path" >> "$shell_config"
        echo 'export PATH=$JAVA_HOME/bin:$PATH' >> "$shell_config"
        echo -e "${GREEN}Added JAVA_HOME to $shell_config${NC}"
        echo -e "${YELLOW}Run 'source $shell_config' or restart terminal to apply.${NC}"
    fi
}

# --- Main ---

clear
echo -e "${BLUE}${BOLD}Java Development Setup${NC}"
echo -e "-----------------------"

install_java

echo -e "\n${GREEN}Setup Complete! ☕${NC}\n"
