#!/bin/bash

# Colors
BLUE='\033[1;34m'
GREEN='\033[1;32m'
NC='\033[0m' # No Color

echo -e "${BLUE}🔹feat: installing prerequisites (gnupg, curl)...${NC}"
sudo apt-get install -y gnupg curl
echo -e "${GREEN}chore: gnupg-curl is installed ${NC}"

echo -e "${BLUE}🔹feat: adding MongoDB-GPG key...${NC}"
curl -fsSL https://www.mongodb.org/static/pgp/server-8.0.asc | \
   sudo gpg -o /usr/share/keyrings/mongodb-server-8.0.gpg --dearmor
echo -e "${GREEN}chore: GPG-KEY added successfully ${NC}"

echo -e "${BLUE}🔹feat: adding MongoDB-repository...${NC}"
echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-8.0.gpg ] https://repo.mongodb.org/apt/ubuntu noble/mongodb-org/8.0 multiverse" | \
   sudo tee /etc/apt/sources.list.d/mongodb-org-8.0.list
echo -e "${GREEN}chore: repository added successfully ${NC}"

echo -e "${BLUE}🔹feat: updating packages list...${NC}"
sudo apt-get update -y
echo -e "${GREEN}chore: packages updated ${NC}"

echo -e "${BLUE}🔹feat: installing-MongoDB...${NC}"
sudo apt-get install -y mongodb-org
echo -e "${GREEN}chore: mongoDB installed successfully ${NC}"

echo -e "${BLUE}🔹feat: starting MongoDB-service...${NC}"
sudo systemctl start mongod
echo -e "${GREEN}chore: mongod-service start successfully ${NC}"

echo -e "${BLUE}🔹feat: enabling MongoDB to start on system boot...${NC}"
sudo systemctl enable mongod
echo -e "${GREEN}chore: service start added in system-boot${NC}"

echo -e "${BLUE}🔹feat: checking MongoDB service-status...${NC}"
sudo systemctl status mongod --no-pager
echo -e "${GREEN}chore: service-status is active or not if active show ${GREEN} active ${NC}"

echo -e "${BLUE}MongoDB installation, startup and auto-start setup completed successfully! ${NC}"

