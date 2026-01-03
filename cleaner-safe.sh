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
read -p "➡️ Do you want to continue? (y/N): " confirm
if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
  echo -e "${RED}❌ Cleanup aborted by user${NC}"
  exit 0
fi
sudo -v
echo -e "${GREEN}✔ Sudo access confirmed${NC}"
echo ""

# ================= APT =================
echo -e "${BLUE}🔹 APT cleanup started...${NC}"
sudo apt update -y
sudo apt full-upgrade -y
sudo apt autoremove -y
sudo apt autoclean -y
sudo apt clean
rm -rf ~/.cache/*
echo -e "${GREEN}✔ APT cleanup completed${NC}"
echo ""

# ================= SNAP =================
echo -e "${BLUE}🔹 SNAP cleanup started...${NC}"
snap list --all | awk '/disabled/{print $1, $3}' | while read s r; do
  sudo snap remove "$s" --revision="$r"
done
rm -rf ~/snap/*/*/.cache
rm -rf ~/snap/*/*/.local/share/Trash/files/*
echo -e "${GREEN}✔ SNAP cleanup completed${NC}"
echo ""

# ================= BROWSERS =================
echo -e "${BLUE}🔹 Browser cache cleanup...${NC}"
rm -rf ~/.cache/google-chrome \
       ~/.cache/chromium \
       ~/.cache/BraveSoftware \
       ~/.cache/mozilla/firefox/*/cache2
echo -e "${GREEN}✔ Browser caches cleaned${NC}"
echo ""

# ================= IDEs =================
echo -e "${BLUE}🔹 IDE cache cleanup...${NC}"
rm -rf ~/.cache/Google/AndroidStudio* \
       ~/.AndroidStudio*/system/{caches,log,tmp} \
       ~/.config/Code/{Cache,CachedData,GPUCache} \
       ~/.config/Cursor/{Cache,CachedData,GPUCache} \
       ~/.config/Windsurf/{Cache,CachedData,GPUCache} \
       ~/.cache/{Cursor,Windsurf,antigravity} \
       ~/.config/antigravity/{Cache,logs}
echo -e "${GREEN}✔ IDE caches cleaned${NC}"
echo ""

# ================= PYTHON =================
echo -e "${BLUE}🔹 Python cache cleanup...${NC}"
find ~ -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null
rm -rf ~/.cache/pip
echo -e "${GREEN}✔ Python caches cleaned${NC}"
echo ""

# ================= NODE / JS =================
echo -e "${BLUE}🔹 Node / Yarn / pnpm / Bun cache cleanup...${NC}"
rm -rf ~/.npm \
       ~/.cache/{npm,node-gyp,yarn,bun} \
       ~/.yarn/cache \
       ~/.pnpm-store \
       ~/.local/share/pnpm/store \
       ~/.bun/install/cache
echo -e "${GREEN}✔ Node ecosystem caches cleaned${NC}"
echo ""

# ================= DOCKER =================
echo -e "${BLUE}🔹 Docker environment check...${NC}"
DOCKER_READY=false

if command -v docker-desktop &> /dev/null || [ -d "$HOME/.docker/desktop" ]; then
  systemctl --user start docker-desktop || true
  sleep 10
  docker info &> /dev/null && DOCKER_READY=true
elif systemctl list-unit-files | grep -q docker.service; then
  sudo systemctl start docker
  sleep 5
  docker info &> /dev/null && DOCKER_READY=true
fi

if [ "$DOCKER_READY" = true ]; then
  echo -e "${BLUE}🔹 Docker SAFE cleanup...${NC}"
  docker system df
  docker container prune -f
  docker image prune -af
  docker builder prune -af
  docker system df
  echo -e "${GREEN}✔ Docker cleanup completed${NC}"
else
  echo -e "${YELLOW}⚠️ Docker not ready. Skipped.${NC}"
fi
echo ""

# ================= TEMP =================
echo -e "${BLUE}🔹 Temporary files cleanup...${NC}"
sudo rm -rf /tmp/* /var/tmp/*
echo -e "${GREEN}✔ Temporary files cleaned${NC}"
echo ""

# ================= DONE =================
echo -e "${GREEN}✅ FULL CLEANUP COMPLETED SUCCESSFULLY${NC}"
df -h /
echo -e "${YELLOW}⚠️ Restart apps to fully release memory${NC}"
