#!/bin/bash
# Author: Bhavin Pathak
# Description: Database Server Installer (Postgres, Mongo, Redis, Milvus)

set -e

# Styling
BOLD='\033[1m'
BLUE='\033[1;34m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
RED='\033[1;31m'
NC='\033[0m'

print_msg() {
    echo -e "\n${BLUE}${BOLD}>>> $1...${NC}\n"
}

is_installed() {
    command -v "$1" &> /dev/null
}

ask_install() {
    local name=$1
    echo -e "${YELLOW}Install ${BOLD}$name${NC}${YELLOW}? [y/n]${NC}"
    read -p "> " choice
    case "$choice" in 
        [yY]*) return 0 ;;
        *) return 1 ;;
    esac
}

# --- Installers ---

install_postgres() {
    if is_installed psql; then
        echo -e "${GREEN}PostgreSQL is already installed.${NC}"
        return
    fi
    print_msg "Installing PostgreSQL"
    
    # Repo & GPG (Using original logic)
    sudo apt install -y curl ca-certificates
    sudo install -d /usr/share/postgresql-common/pgdg
    sudo curl -o /usr/share/postgresql-common/pgdg/apt.postgresql.org.asc --fail https://www.postgresql.org/media/keys/ACCC4CF8.asc
    
    . /etc/os-release
    sudo sh -c "echo 'deb [signed-by=/usr/share/postgresql-common/pgdg/apt.postgresql.org.asc] https://apt.postgresql.org/pub/repos/apt $VERSION_CODENAME-pgdg main' > /etc/apt/sources.list.d/pgdg.list"
    
    sudo apt update
    sudo apt -y install postgresql
    
    # Enable service
    sudo systemctl enable postgresql
    sudo systemctl start postgresql
    
    echo -e "${GREEN}PostgreSQL Installed & Started!${NC}"
}

install_mongo() {
    if is_installed mongod; then
        echo -e "${GREEN}MongoDB is already installed.${NC}"
        return
    fi
    print_msg "Installing MongoDB (Community)"
    
    # Repo & GPG (Using original logic for MongoDB 8.0/latest)
    sudo apt-get install -y gnupg curl
    curl -fsSL https://www.mongodb.org/static/pgp/server-8.0.asc | \
       sudo gpg -o /usr/share/keyrings/mongodb-server-8.0.gpg --dearmor --yes
       
    echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-8.0.gpg ] https://repo.mongodb.org/apt/ubuntu $(lsb_release -cs)/mongodb-org/8.0 multiverse" | \
       sudo tee /etc/apt/sources.list.d/mongodb-org-8.0.list
       
    sudo apt-get update -y
    sudo apt-get install -y mongodb-org
    
    # Enable service
    sudo systemctl start mongod
    sudo systemctl enable mongod
    
    echo -e "${GREEN}MongoDB Installed & Started!${NC}"
}

install_redis() {
    if is_installed redis-server; then
        echo -e "${GREEN}Redis is already installed.${NC}"
        return
    fi
    print_msg "Installing Redis Server"
    
    sudo apt update
    sudo apt install -y redis-server
    
    # Enable service
    sudo systemctl enable redis-server
    sudo systemctl start redis-server
    
    echo -e "${GREEN}Redis Installed & Started!${NC}"
}

install_milvus() {
    if dpkg -l | grep -q milvus; then
        echo -e "${GREEN}Milvus is already installed.${NC}"
        return
    fi
    print_msg "Installing Milvus (Standalone .deb)"
    
    # Download logic (Updated version or keep existing if preferred)
    # Using the link from the original file (v2.3.16)
    wget -O milvus.deb https://github.com/milvus-io/milvus/releases/download/v2.3.16/milvus_2.3.16-1_amd64.deb
    
    sudo dpkg -i milvus.deb
    sudo apt-get -f install -y
    
    rm milvus.deb
    
    # Enable service
    sudo systemctl start milvus.service
    sudo systemctl enable milvus.service
    
    echo -e "${GREEN}Milvus Installed & Started!${NC}"
}

# --- Main ---

clear
echo -e "${BLUE}${BOLD}Database Server Setup${NC}"
echo -e "---------------------"
echo -e "${YELLOW}Note: This installs the Database SERVERS. Use db-view.sh for GUIs.${NC}\n"

ask_install "PostgreSQL" && install_postgres
ask_install "MongoDB" && install_mongo
ask_install "Redis" && install_redis
ask_install "Milvus (Vector DB)" && install_milvus

echo -e "\n${GREEN}Database Setup Complete! 🗄️${NC}\n"
