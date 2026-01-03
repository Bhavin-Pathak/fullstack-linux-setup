#!/bin/bash
set -e

# Colors
BLUE='\033[1;34m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
RED='\033[1;31m'
NC='\033[0m'

# Start Cleanup Process
echo -e "${BLUE}🔹 Starting Safe Cleanup...${NC}"
echo -e "${YELLOW}⚠️ Only unused & regeneratable cache will be removed${NC}"
echo -e "${YELLOW}⚠️ Projects, OS, SDKs, Docker volumes & DB data are SAFE${NC}"
echo ""

# Confirm before proceeding
echo -e "${YELLOW}⚠️ This script will remove all unused and regeneratable cache.${NC}"
echo ""
read -p "➡️ Do you want to continue? (y/N): " confirm
if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
  echo -e "${RED}❌ Cleanup aborted by user${NC}"
  exit 0
fi

sudo -v

# Snap Cleanup
echo -e "${BLUE}🔹 Cleaning SNAP apps...${NC}"
echo -e "${BLUE}🔹 Removing old SNAP revisions...${NC}"
snap list --all | awk '/disabled/{print $1, $3}' | while read snapname revision; do
  sudo snap remove "$snapname" --revision="$revision"
done
echo -e "${GREEN}✔ SNAP old revisions removed${NC}"
echo -e "${BLUE}🔹 Cleaning SNAP cache & trash...${NC}"
rm -rf ~/snap/*/*/.cache
rm -rf ~/snap/*/*/.local/share/Trash/files/*
echo -e "${GREEN}✔ SNAP cache & trash cleaned${NC}"

# APT Cleanup
echo -e "${BLUE}🔹 Cleaning APT cache & unused packages...${NC}"
sudo apt autoremove -y
sudo apt autoclean -y
sudo apt clean
echo -e "${GREEN}✔ APT cleanup completed${NC}"

# Browser Caches
echo -e "${BLUE}🔹 Cleaning Browser caches...${NC}"
rm -rf ~/.cache/google-chrome
rm -rf ~/.cache/chromium
rm -rf ~/.cache/BraveSoftware
rm -rf ~/.cache/mozilla/firefox/*/cache2
echo -e "${GREEN}✔ Browser caches cleaned${NC}"

# IDE's Caches
echo -e "${BLUE}🔹 Cleaning IDE's caches...${NC}"
rm -rf ~/.cache/Google/AndroidStudio*
rm -rf ~/.AndroidStudio*/system/caches
rm -rf ~/.AndroidStudio*/system/log
rm -rf ~/.AndroidStudio*/system/tmp
rm -rf ~/.config/Code/{Cache,CachedData,GPUCache}
rm -rf ~/.config/Cursor/{Cache,CachedData,GPUCache}
rm -rf ~/.config/Windsurf/{Cache,CachedData,GPUCache}
rm -rf ~/.cache/{Cursor,Windsurf}
rm -rf ~/.cache/antigravity
rm -rf ~/.config/antigravity/{Cache,logs}
echo -e "${GREEN}✔ IDE's caches cleaned${NC}"

# Python Caches & Pip Cache
echo -e "${BLUE}🔹 Cleaning Python caches...${NC}"
find ~ -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null
rm -rf ~/.cache/pip
echo -e "${GREEN}✔ Python cache cleaned${NC}"

# Node / Yarn / pnpm / Bun Caches
echo -e "${BLUE}🔹 Cleaning Node / Yarn / pnpm / Bun caches...${NC}"

# npm
rm -rf ~/.npm
rm -rf ~/.cache/npm
rm -rf ~/.cache/node-gyp
rm -rf ~/.cache/yarn
rm -rf ~/.yarn/cache
rm -rf ~/.pnpm-store
rm -rf ~/.local/share/pnpm/store
rm -rf ~/.bun/install/cache
rm -rf ~/.cache/bun

echo -e "${GREEN}✔ Node / Yarn / pnpm / Bun caches cleaned${NC}"

# Docker Cleanup
if command -v docker &> /dev/null; then
  echo -e "${BLUE}🔹 Docker SAFE cleanup started...${NC}"
  echo -e "${YELLOW}✔ Running containers SAFE${NC}"
  echo -e "${YELLOW}✔ Volumes & DB data SAFE${NC}"
  echo ""
  docker system df
  echo -e "${BLUE}🔹 Removing stopped containers...${NC}"
  docker container prune -f
  echo -e "${BLUE}🔹 Removing UNUSED Docker images...${NC}"
  docker image prune -af
  echo -e "${BLUE}🔹 Removing Docker build cache...${NC}"
  docker builder prune -af
  docker system df
  echo -e "${GREEN}✔ Docker cleanup completed${NC}"
fi
# Temporary Files Cleanup
echo -e "${BLUE}🔹 Cleaning temporary files...${NC}"
sudo rm -rf /tmp/*
sudo rm -rf /var/tmp/*
echo -e "${GREEN}✔ Temporary files cleaned${NC}"

# ================= DONE =================
echo ""
echo -e "${GREEN}✅ CLEANUP COMPLETED !!${NC}"
df -h /
echo ""
echo -e "${YELLOW}⚠️ Remember to restart applications to free up memory from cleaned caches.${NC}"