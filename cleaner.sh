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
sudo apt full-upgrade -y
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
# Extra safety from old script
rm -rf ~/snap/*/*/.local/share/Trash/files/*

# 4. Applications (Browsers / IDEs)
print_msg "Cleaning App Caches (Browsers, IDEs, Thumbnails)"
rm -rf ~/.cache/google-chrome \
       ~/.cache/chromium \
       ~/.cache/BraveSoftware \
       ~/.cache/mozilla/firefox/*/cache2 \
       ~/.cache/thumbnails/* 

# IDE Specifics (Restored from old script)
rm -rf ~/.cache/Google/AndroidStudio* \
       ~/.AndroidStudio*/system/{caches,log,tmp} \
       ~/.config/Code/{Cache,CachedData,GPUCache} \
       ~/.config/Cursor/{Cache,CachedData,GPUCache} \
       ~/.config/Windsurf/{Cache,CachedData,GPUCache} \
       ~/.cache/{Cursor,Windsurf,antigravity} \
       ~/.config/antigravity/{Cache,logs}

# 5. Python (Restored robust logic)
print_msg "Cleaning Python Caches"
find ~ -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null
rm -rf ~/.cache/pip

# 6. Node / JS (Restored robust logic)
print_msg "Cleaning Node/JS Caches"
rm -rf ~/.npm \
       ~/.cache/{npm,node-gyp,yarn,bun} \
       ~/.yarn/cache \
       ~/.pnpm-store \
       ~/.local/share/pnpm/store \
       ~/.bun/install/cache

# 7. Trash
print_msg "Emptying User Trash"
rm -rf ~/.local/share/Trash/*

# 8. Docker (Restored robust readiness checks)
print_msg "Checking Docker Environment"
DOCKER_READY=false

if command -v docker-desktop &> /dev/null || [ -d "$HOME/.docker/desktop" ]; then
  # Try to start Docker Desktop if present
  systemctl --user start docker-desktop || true
  sleep 5
  docker info &> /dev/null && DOCKER_READY=true
elif systemctl list-unit-files | grep -q docker.service; then
  # Fallback to standard Docker Engine
  sudo systemctl start docker
  sleep 3
  docker info &> /dev/null && DOCKER_READY=true
fi

if [ "$DOCKER_READY" = true ]; then
  echo -e "${YELLOW}Pruning Docker (unused images, containers, networks)...${NC}"
  docker system df
  docker container prune -f
  docker image prune -af
  docker builder prune -af
  docker system df
  echo -e "${GREEN}✔ Docker cleanup completed${NC}"
else
  echo -e "${YELLOW}⚠️ Docker not running. Skipped Docker cleanup.${NC}"
fi

# 9. Temp Files
print_msg "Cleaning Temp Files"
sudo rm -rf /tmp/* /var/tmp/* 2>/dev/null || true

# --- Finish ---

echo -e "\n${GREEN}✨ System Cleaned Successfully! ✨${NC}"
df -h / | grep /
echo -e "\n"
