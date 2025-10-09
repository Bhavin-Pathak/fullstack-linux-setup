#!/bin/bash
set -e

# Colors
BLUE='\033[1;34m'
GREEN='\033[1;32m'
RED='\033[1;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}🔹Updating and upgrading system packages...${NC}"
sudo apt update && sudo apt upgrade -y
echo -e "${GREEN}Packages updating is completed ${NC}"

echo -e "${BLUE}🔹Installing curl...${NC}"
sudo apt install curl -y
echo -e "${GREEN}Curl installation is completed ${NC}"

echo -e "${BLUE}🔹Installing NVM (if not already installed)...${NC}"
if [ ! -d "$HOME/.nvm" ]; then
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
fi
echo -e "${GREEN}NVM installed completed ${NC}"

echo -e "${BLUE}🔹Setting-up NVM environment...${NC}"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
echo -e "${GREEN}NVM environment setup completed ${NC}"

echo -e "${BLUE}🔹Installing latest LTS version of Node.js using NVM...${NC}"
nvm install --lts
nvm use --lts
nvm alias default 'lts/*'
echo -e "${GREEN}Latest NodeJS version is installed in system ${NC}"

echo -e "${BLUE}🔹Enabling Corepack (for pnpm and yarn)...${NC}"
corepack enable
corepack prepare pnpm@latest --activate
corepack prepare yarn@stable --activate
echo -e "${GREEN}Yarn and pnpm is installed completed ${NC}"

echo -e "${BLUE}🔹Installing nodemon globally...${NC}"
npm install -g nodemon
echo -e "${GREEN}Nodemon is globally installed in system ${NC}"

echo -e "${BLUE}🔹Installing Bun globally...${NC}"
npm install -g bun
echo -e "${GREEN}Bun installed globally in system ${NC}"

echo -e "${BLUE}🔹Enabling Corepack for all new sessions...${NC}"
echo 'corepack enable' >> ~/.bashrc
echo -e "${GREEN}Corepack-enable in system ${NC}"

echo -e "${GREEN}Installation complete!${NC}"

echo -e "${BLUE}🔹Reloading bashrc to apply changes...${NC}"
source ~/.bashrc
echo -e "${GREEN}Reloading bashrc completed ${NC}"

echo -e "${BLUE}🔹Verifying Versions Of node, npm, nvm, pnpm, yarn, nodemon & bun...${NC}"
echo -e "NodeJS Version is : $(node -v)"
echo -e "NPM Version is : $(npm -v)"
echo -e "NVM Version is : $(nvm -v)"
echo -e "PNPM Version is : $(pnpm -v)"
echo -e "Yarn Version is : $(yarn -v)"
echo -e "Nodemon Version is : $(nodemon -v)"
echo -e "Bun Version is : $(bun -v)"

