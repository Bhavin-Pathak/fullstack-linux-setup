#!/bin/bash
set -e

# Colors
BLUE='\033[1;34m'
GREEN='\033[1;32m'
RED='\033[1;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}🔹Installing prerequisites (curl, ca-certificates)...${NC}"
sudo apt install -y curl ca-certificates
echo -e "${GREEN}Dependency installed completed ${NC}"

echo -e "${BLUE}🔹Creating keyring-directory...${NC}"
sudo install -d /usr/share/postgresql-common/pgdg
echo -e "${GREEN}Directory created successfully ${NC}"

echo -e "${BLUE}🔹Downloading PostgreSQL GPG-key...${NC}"
sudo curl -o /usr/share/postgresql-common/pgdg/apt.postgresql.org.asc --fail https://www.postgresql.org/media/keys/ACCC4CF8.asc
echo -e "${GREEN}GPG-KEY downloaded sucessfully ${NC}"

echo -e "${BLUE}🔹Adding PostgreSQL repository...${NC}"
. /etc/os-release
sudo sh -c "echo 'deb [signed-by=/usr/share/postgresql-common/pgdg/apt.postgresql.org.asc] https://apt.postgresql.org/pub/repos/apt $VERSION_CODENAME-pgdg main' > /etc/apt/sources.list.d/pgdg.list"
echo -e "${GREEN}Repository added successfully ${NC}"

echo -e "${BLUE}🔹Updating package list...${NC}"
sudo apt update
echo -e "${GREEN}Packages updated ${NC}"

echo -e "${BLUE}🔹Installing PostgreSQL...${NC}"
sudo apt -y install postgresql
echo -e "${GREEN}Postgresql installed successfully ${NC}"

echo -e "${BLUE}🔹Starting PostgreSQL...${NC}"
sudo systemctl start postgresql
sudo systemctl enable postgresql
sudo systemctl status postgresql
echo -e "${GREEN}PostgreSQL service started and enabled ${NC}"

echo -e "${GREEN}PostgreSQL installation completed successfully!${NC}"

echo -e "${BLUE}Verifying installed versions...${NC}"
echo -e "${GREEN}PostgreSQL Version is: $(psql --version)${NC}"