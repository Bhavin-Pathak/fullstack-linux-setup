#!/bin/bash
set -e

# Colors
BLUE='\033[1;34m'
GREEN='\033[1;32m'
NC='\033[0m'


echo -e "${BLUE}🔹Installing Windsurf Codeium AI IDE...${NC}"
sudo apt-get install wget gpg -y
wget -qO- "https://windsurf-stable.codeiumdata.com/wVxQEIWkwPUEAGf3/windsurf.gpg" | gpg --dearmor > windsurf-stable.gpg
sudo install -D -o root -g root -m 644 windsurf-stable.gpg /etc/apt/keyrings/windsurf-stable.gpg
echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/windsurf-stable.gpg] https://windsurf-stable.codeiumdata.com/wVxQEIWkwPUEAGf3/apt stable main" | sudo tee /etc/apt/sources.list.d/windsurf.list > /dev/null
rm -f windsurf-stable.gpg
sudo apt install apt-transport-https -y
sudo apt update
sudo apt install windsurf -y
echo -e "${GREEN}Windsurf Codeium AI IDE installation completed ${NC}"
echo -e "${GREEN}You can launch Windsurf IDE by running 'windsurf' command in the terminal.${NC}"

echo -e "${GREEN}🚀 Windsurf Codeium AI IDE setup completed!${NC}"