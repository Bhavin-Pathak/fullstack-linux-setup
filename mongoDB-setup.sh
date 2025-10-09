#!/bin/bash
set -e

# Colors
BLUE='\033[1;34m'
GREEN='\033[1;32m'
NC='\033[0m' # No Color

echo -e "${BLUE}🔹Installing prerequisites (gnupg, curl)...${NC}"
sudo apt-get install -y gnupg curl
echo -e "${GREEN}Gnupg-curl is installed ${NC}"

echo -e "${BLUE}🔹Adding MongoDB-GPG key...${NC}"
curl -fsSL https://www.mongodb.org/static/pgp/server-8.0.asc | \
   sudo gpg -o /usr/share/keyrings/mongodb-server-8.0.gpg --dearmor
echo -e "${GREEN}GPG-KEY added successfully ${NC}"

echo -e "${BLUE}🔹Adding MongoDB-repository...${NC}"
echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-8.0.gpg ] https://repo.mongodb.org/apt/ubuntu noble/mongodb-org/8.0 multiverse" | \
   sudo tee /etc/apt/sources.list.d/mongodb-org-8.0.list
echo -e "${GREEN}Repository added successfully ${NC}"

echo -e "${BLUE}🔹Updating packages list...${NC}"
sudo apt-get update -y
echo -e "${GREEN}Packages updated ${NC}"

echo -e "${BLUE}🔹Installing-MongoDB...${NC}"
sudo apt-get install -y mongodb-org
echo -e "${GREEN}MongoDB installed successfully ${NC}"

echo -e "${BLUE}🔹Starting MongoDB-service...${NC}"
sudo systemctl start mongod
echo -e "${GREEN}Mongod-service start successfully ${NC}"

echo -e "${BLUE}🔹Enabling MongoDB to start on system boot...${NC}"
sudo systemctl enable mongod
echo -e "${GREEN}Service start added in system-boot${NC}"

echo -e "${BLUE}🔹Checking MongoDB service-status...${NC}"
sudo systemctl status mongod --no-pager
echo -e "${GREEN}Service-status is active or not if active show ${GREEN} active ${NC}"

echo -e "${BLUE}MongoDB installation, startup and auto-start setup completed successfully! ${NC}"

echo -e "${GREEN}Verifying MongoDB Version ${NC}"
echo -e "${BLUE}🔹MongoDB Version is: $(mongod --version) ${NC}"