#!/bin/bash
# Author: Bhavin Pathak
# Description: Safe System Cleanup & Maintenance Tool

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

# --- Confirmation ---

clear
echo -e "${BLUE}${BOLD}System Cleanup Tool${NC}"
echo -e "-------------------"
echo -e "${YELLOW}⚠️  This will remove unused caches, temp files, and Docker items.${NC}"
echo -e "${YELLOW}⚠️  Your projects and personal data are SAFE.${NC}\n"

read -p "Start cleanup? (y/N): " choice
if [[ "$choice" != "y" && "$choice" != "Y" ]]; then
    echo -e "${RED}Aborted.${NC}"
    exit 0
fi

# Request Sudo upfront
sudo -v

# --- Cleaning Steps ---

# 1. APT
print_msg "Cleaning APT (Packages)"
sudo apt update -y
sudo apt autoremove -y
sudo apt autoclean -y
sudo apt clean
rm -rf ~/.cache/*

# 2. System Logs (Journal)
print_msg "Vacuuming System Logs (>3 days)"
sudo journalctl --vacuum-time=3d

# 3. Snap
print_msg "Cleaning Snap Cache"
# Remove disabled snaps
snap list --all | awk '/disabled/{print $1, $3}' | while read s r; do
    sudo snap remove "$s" --revision="$r"
done
rm -rf ~/snap/*/*/.cache
sudo rm -rf /var/lib/snapd/cache/*

# 4. Applications (Browsers / IDEs)
print_msg "Cleaning App Caches (Browsers, IDEs, Thumbnails)"
rm -rf ~/.cache/google-chrome \
       ~/.cache/chromium \
       ~/.cache/BraveSoftware \
       ~/.cache/mozilla/firefox/*/cache2 \
       ~/.cache/thumbnails/* \
       ~/.cache/pip \
       ~/.npm/_cacache
       
# IDE Specifics
rm -rf ~/.config/Code/Cache \
       ~/.config/Code/CachedData \
       ~/.config/Cursor/Cache \
       ~/.config/Cursor/CachedData \
       ~/.config/antigravity/Cache

# 5. Trash
print_msg "Emptying User Trash"
rm -rf ~/.local/share/Trash/*

# 6. Docker
print_msg "Checking Docker"
if command -v docker &> /dev/null; then
    echo -e "${YELLOW}Pruning Docker (unused images, containers, networks)...${NC}"
    docker system prune -f
else
    echo "Docker not found, skipping."
fi

# 7. Temp Files
print_msg "Cleaning Temp Files"
sudo rm -rf /tmp/* 2>/dev/null || true
sudo rm -rf /var/tmp/* 2>/dev/null || true

# --- Finish ---

echo -e "\n${GREEN}✨ System Cleaned Successfully! ✨${NC}"
df -h / | grep /
echo -e "\n"
