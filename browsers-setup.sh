#!/bin/bash
set -e

# ==========================================
#  🎨 Color & Style Configuration
# ==========================================
BOLD='\033[1m'
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
CYAN='\033[1;36m'
NC='\033[0m' # No Color

# ==========================================
#  🛠 Helper Functions
# ==========================================

# Print a stylish section header
print_header() {
    echo -e "\n${BLUE}${BOLD}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${CYAN}${BOLD}   🚀  $1   ${NC}"
    echo -e "${BLUE}${BOLD}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
}

# Print success message
print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

# Print info message
print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

# Print warning/skip message
print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

# Check if a command exists
check_installed() {
    if command -v "$1" &> /dev/null; then
        return 0
    else
        return 1
    fi
}

# Ask for user confirmation with a stylish prompt
ask_user() {
    local browser_name="$1"
    echo -e "${YELLOW}❓ Do you want to install ${BOLD}${browser_name}${NC}${YELLOW}?${NC}"
    while true; do
        read -p "$(echo -e "${CYAN}   [Y/n] > ${NC}")" yn
        case $yn in
            [Yy]*|"" ) return 0;; # Default to Yes
            [Nn]* ) return 1;;
            * ) echo -e "${RED}Please answer yes (y) or no (n).${NC}";;
        esac
    done
}

# ==========================================
#  📦 Installation Logic
# ==========================================

# Install Snap if not present
ensure_snap() {
    print_header "System Check: Snapd"
    if ! check_installed snap; then
        print_info "Snap is not installed. Installing snapd..."
        sudo apt update
        sudo apt install snapd -y
        print_success "Snap installed successfully."
    else
        print_success "Snap is already installed."
    fi
}

# Install Google Chrome via .deb
install_chrome() {
    if check_installed google-chrome; then
        print_success "Google Chrome is already installed ($(google-chrome --version))."
    else
        print_info "Downloading Google Chrome..."
        wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O google-chrome.deb
        
        print_info "Installing Google Chrome..."
        sudo apt install ./google-chrome.deb -y
        rm google-chrome.deb
        print_success "Google Chrome installed successfully!"
    fi
}

# Generic function to install Snap browsers
install_snap_browser() {
    local browser_name="$1"
    local snap_package="$2"
    
    if check_installed "$snap_package"; then
        print_success "$browser_name is already installed."
    else
        print_info "Installing $browser_name via Snap..."
        sudo snap install "$snap_package"
        print_success "$browser_name installed successfully!"
    fi
}

# ==========================================
#  🚀 Main Execution Flow
# ==========================================
clear
print_header "Interactive Browser Installation Script"

ensure_snap

# 1. Google Chrome
if ask_user "Google Chrome"; then
    install_chrome
else
    print_warning "Skipping Google Chrome."
fi

# 2. Brave Browser
if ask_user "Brave Browser"; then
    install_snap_browser "Brave" "brave"
else
    print_warning "Skipping Brave Browser."
fi

# 3. Firefox
if ask_user "Firefox"; then
    install_snap_browser "Firefox" "firefox"
else
    print_warning "Skipping Firefox."
fi

# 4. Opera
if ask_user "Opera"; then
    install_snap_browser "Opera" "opera"
else
    print_warning "Skipping Opera."
fi

# 5. Chromium
if ask_user "Chromium"; then
    install_snap_browser "Chromium" "chromium"
else
    print_warning "Skipping Chromium."
fi

print_header "Installation Process Completed"
print_success "All requested browsers have been processed."
echo -e "\n${CYAN}Enjoy your web surfing! 🌐${NC}\n"
