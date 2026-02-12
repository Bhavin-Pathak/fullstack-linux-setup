#!/bin/bash
# Author: Bhavin Pathak
# Description: Productivity & Media Apps Installer

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

ask_install() {
    local name=$1
    echo -e "${YELLOW}Install ${BOLD}$name${NC}${YELLOW}? [y/n]${NC}"
    read -p "> " choice
    case "$choice" in 
        [yY]*) return 0 ;;
        *) return 1 ;;
    esac
}

# ==========================================
# 1. Communication
# ==========================================
print_msg "Communication Apps"

if ask_install "Slack"; then
    sudo snap install slack
fi

if ask_install "Discord"; then
    sudo snap install discord
fi

if ask_install "Zoom"; then
    sudo snap install zoom-client
fi

if ask_install "Microsoft Teams"; then
    sudo snap install teams-for-linux
fi

# ==========================================
# 2. Media & Entertainment
# ==========================================
print_msg "Media Apps"

if ask_install "Spotify"; then
    sudo snap install spotify
fi

if ask_install "VLC Media Player"; then
    sudo snap install vlc
fi

if ask_install "OBS Studio (Screen Recording)"; then
    sudo add-apt-repository ppa:obsproject/obs-studio -y
    sudo apt update
    sudo apt install -y obs-studio
fi


# ==========================================
# 3. Utilities
# ==========================================
print_msg "Utility Apps"

if ask_install "Flameshot (Screenshots)"; then
    sudo apt install -y flameshot
fi

if ask_install "GParted (Disk Management)"; then
    sudo apt install -y gparted
fi

echo -e "\n${GREEN}Apps Installation Complete! 🎧${NC}\n"
