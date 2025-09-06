#!/bin/bash

# Colors
BLUE='\033[1;34m'
GREEN='\033[1;32m'
RED='\033[1;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}🔹feat: installing prerequisites (curl, ca-certificates)...${NC}"
sudo apt install -y curl ca-certificates
echo -e "${GREEN}chore: dependency installed completed ${NC}"

echo -e "${BLUE}🔹feat: creating keyring-directory...${NC}"
sudo install -d /usr/share/postgresql-common/pgdg
echo -e "${GREEN}chore: directory created successfully ${NC}"

echo -e "${BLUE}🔹feat: downloading PostgreSQL GPG-key...${NC}"
sudo curl -o /usr/share/postgresql-common/pgdg/apt.postgresql.org.asc --fail https://www.postgresql.org/media/keys/ACCC4CF8.asc
echo -e "${GREEN}chore: GPG-KEY downloaded sucessfully ${NC}"

echo -e "${BLUE}🔹feat: adding PostgreSQL repository...${NC}"
. /etc/os-release
sudo sh -c "echo 'deb [signed-by=/usr/share/postgresql-common/pgdg/apt.postgresql.org.asc] https://apt.postgresql.org/pub/repos/apt $VERSION_CODENAME-pgdg main' > /etc/apt/sources.list.d/pgdg.list"
echo -e "${GREEN}chore: repository added successfully ${NC}"

echo -e "${BLUE}🔹feat: updating package list...${NC}"
sudo apt update
echo -e "${GREEN}chore: packages updated ${NC}"

echo -e "${BLUE}🔹feat: installing PostgreSQL...${NC}"
sudo apt -y install postgresql
echo -e "${GREEN}chore: postgresql installed successfully ${NC}"

echo -e "${GREEN}PostgreSQL installation completed successfully!${NC}"
echo -e "${RED}fix: To check status, run: sudo systemctl status postgresql${NC}"
echo -e "${RED}fix: To start service manually: sudo systemctl start postgresql${NC}"

