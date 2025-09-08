#!/bin/bash

# Colors
BLUE='\033[1;34m'
GREEN='\033[1;32m'
RED='\033[1;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}🔹feat: updating and upgrading system packages...${NC}"
sudo apt update && sudo apt upgrade -y
echo -e "${GREEN}chore: packages updating is completed ${NC}"

echo -e "${BLUE}🔹feat: installing curl...${NC}"
sudo apt install curl -y
echo -e "${GREEN}chore: curl installation is completed ${NC}"

echo -e "${BLUE}🔹feat: installing NVM (if not already installed)...${NC}"
if [ ! -d "$HOME/.nvm" ]; then
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
fi
echo -e "${GREEN}chore: NVM installed completed ${NC}"

echo -e "${BLUE}🔹feat: setting-up NVM environment...${NC}"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
echo -e "${GREEN}chore: NVM environment setup completed ${NC}"

echo -e "${BLUE}🔹feat: installing latest LTS version of Node.js using NVM...${NC}"
nvm install --lts
nvm use --lts
nvm alias default 'lts/*'
echo -e "${GREEN}chore: latest NodeJS version is installed in system ${NC}"

echo -e "${BLUE}🔹feat: enabling Corepack (for pnpm and yarn)...${NC}"
corepack enable
corepack prepare pnpm@latest --activate
corepack prepare yarn@stable --activate
echo -e "${GREEN}chore: yarn and pnpm is installed completed ${NC}"

echo -e "${BLUE}🔹feat: installing nodemon globally...${NC}"
npm install -g nodemon
echo -e "${GREEN}chore: nodemon is globally installed in system ${NC}"

echo -e "${BLUE}🔹feat: installing Bun globally...${NC}"
npm install -g bun
echo -e "${GREEN}chore: bun installed globally in system ${NC}"

echo -e "${BLUE}🔹feat: enabling Corepack for all new sessions...${NC}"
echo 'corepack enable' >> ~/.bashrc
echo -e "${GREEN}chore: corepack-enable in system ${NC}"

echo -e "${GREEN}chore: installation complete!${NC}"
echo -e "${RED}fix: please restart your terminal or run 'source ~/.bashrc' to apply changes.${NC}"

echo -e "${BLUE}🔹chore: verifying-installations...${NC}"
node -v
npm -v
nvm -v
pnpm -v
yarn -v
nodemon -v
bun -v

