#!/bin/bash
# Author: Bhavin Pathak
# Description: Node.js, NVM, Yarn, PNPM & Bun Setup

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

install_node_stack() {
    print_msg "Updating System"
    sudo apt update && sudo apt install -y curl

    # 1. Install NVM
    if [ ! -d "$HOME/.nvm" ]; then
        print_msg "Installing NVM"
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
    else
        echo -e "${GREEN}NVM already installed.${NC}"
    fi

    # Load NVM for this session
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

    # 2. Install Node LTS
    print_msg "Installing Node.js LTS"
    nvm install --lts
    nvm use --lts
    nvm alias default 'lts/*'

    # 3. Corepack (Yarn/PNPM)
    print_msg "Enabling Corepack (Yarn & PNPM)"
    corepack enable
    corepack prepare pnpm@latest --activate
    corepack prepare yarn@stable --activate

    # 4. Globals
    print_msg "Installing Global Tools (Nodemon, Bun)"
    npm install -g nodemon
    # Bun install script
    if ! command -v bun &> /dev/null; then
        curl -fsSL https://bun.sh/install | bash
    fi

    # 5. Smart Config
    local rc_file=$(get_shell_rc)
    print_msg "Configuring Shell: $rc_file"

    # Ensure Corepack is enabled in RC
    if ! grep -q "corepack enable" "$rc_file"; then
        echo "" >> "$rc_file"
        echo "# Node Corepack" >> "$rc_file"
        echo "corepack enable" >> "$rc_file"
        echo -e "${GREEN}Added 'corepack enable' to $rc_file${NC}"
    fi
    
    # NVM usually adds itself, but Bun needs help sometimes
    if ! grep -q "BUN_INSTALL" "$rc_file"; then
        echo "" >> "$rc_file"
        echo "# Bun" >> "$rc_file"
        echo 'export BUN_INSTALL="$HOME/.bun"' >> "$rc_file"
        echo 'export PATH=$BUN_INSTALL/bin:$PATH' >> "$rc_file"
        echo -e "${GREEN}Added Bun to PATH in $rc_file${NC}"
    fi

    echo -e "${YELLOW}Run 'source $rc_file' to apply changes.${NC}"
}

# --- Main ---

clear
echo -e "${BLUE}${BOLD}Node.js & JavaScript Tools Setup${NC}"
echo -e "---------------------------------"

install_node_stack

echo -e "\n${GREEN}Setup Complete! 🟢${NC}"
echo -e "Node: $(node -v)"
echo -e "NPM:  $(npm -v)"
echo -e "Yarn: $(yarn -v)"
echo -e "\n"
