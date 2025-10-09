#!/bin/bash
set -e

# Colors
BLUE='\033[1;34m'
GREEN='\033[1;32m'
NC='\033[0m'

echo -e "${BLUE}🔹Downloading Milvus...${NC}"
wget https://github.com/milvus-io/milvus/releases/download/v2.3.16/milvus_2.3.16-1_amd64.deb
echo -e "${GREEN}Milvus downloaded successfully ${NC}"

echo -e "${BLUE}🔹Updating package list...${NC}"
sudo apt-get update
echo -e "${GREEN}Package list updated ${NC}"

echo -e "${BLUE}🔹Installing Milvus...${NC}"
sudo dpkg -i milvus_2.3.16-1_amd64.deb
echo -e "${GREEN}Milvus installation started ${NC}"

echo -e "${BLUE}🔹Resolving dependencies...${NC}"
sudo apt-get -f install
echo -e "${GREEN}Dependencies resolved, Milvus installation completed ${NC}"

echo -e "${BLUE}🔹Starting Milvus service...${NC}"
sudo systemctl start milvus.service
sudo systemctl enable milvus.service
sudo systemctl status milvus.service
echo -e "${GREEN}Milvus service started and enabled ${NC}"

echo -e "${GREEN}Milvus installed successfully! ${NC}"

echo -e "${GREEN}Verifying Milvus Version ${NC}"
echo -e "Milvus Version is : $(dpkg -l | grep milvus | awk '{print $3}')"
