#!/bin/bash
# Author: Bhavin Pathak
# Description: Complete Database Stack (Servers + GUIs)
# Installs: Postgres, MongoDB, Redis, Milvus + Their Viewers

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
        *) 
            echo -e "${RED}Skipped $name.${NC}"
            return 1 
            ;;
    esac
}

# --- Helpers ---

setup_snap() {
    if ! is_installed snap; then
        print_msg "Installing Snapd"
        sudo apt update && sudo apt install snapd -y
    fi
}

check_libstdc() {
    print_msg "Checking libstdc++ version for Milvus"
    if strings /usr/lib/x86_64-linux-gnu/libstdc++.so.6 | grep -q "GLIBCXX_3.4.29"; then
        echo -e "${GREEN}libstdc++ version is sufficient (GLIBCXX_3.4.29+ detected).${NC}"
    else
        echo -e "${YELLOW}Updating libstdc++...${NC}"
        sudo add-apt-repository ppa:ubuntu-toolchain-r/test -y
        sudo apt update
        sudo apt install gcc-11 g++-11 -y
    fi
}

# --- PostgreSQL Stack ---

install_postgres() {
    if is_installed psql; then
        echo -e "${GREEN}PostgreSQL is already installed.${NC}"
    else
        print_msg "Installing PostgreSQL Server"
        sudo apt install -y curl ca-certificates
        sudo install -d /usr/share/postgresql-common/pgdg
        sudo curl -o /usr/share/postgresql-common/pgdg/apt.postgresql.org.asc --fail https://www.postgresql.org/media/keys/ACCC4CF8.asc
        
        . /etc/os-release
        sudo sh -c "echo 'deb [signed-by=/usr/share/postgresql-common/pgdg/apt.postgresql.org.asc] https://apt.postgresql.org/pub/repos/apt $VERSION_CODENAME-pgdg main' > /etc/apt/sources.list.d/pgdg.list"
        
        sudo apt update
        sudo apt install -y postgresql-16 postgresql-contrib-16
        sudo systemctl enable postgresql
        sudo systemctl start postgresql
        echo -e "${GREEN}PostgreSQL Installed & Started!${NC}"
    fi

    # GUI Prompt
    if ask_install "pgAdmin4 (GUI for Postgres)"; then
        if is_installed pgadmin4; then
            echo -e "${GREEN}pgAdmin4 is already installed.${NC}"
        else
            print_msg "Installing pgAdmin4"
            sudo curl -fsS https://www.pgadmin.org/static/packages_pgadmin_org.pub | sudo gpg --dearmor -o /usr/share/keyrings/packages-pgadmin-org.gpg
            sudo sh -c 'echo "deb [signed-by=/usr/share/keyrings/packages-pgadmin-org.gpg] https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/$(lsb_release -cs) pgadmin4 main" > /etc/apt/sources.list.d/pgadmin4.list'
            sudo apt update
            sudo apt install pgadmin4 -y
            echo -e "${GREEN}pgAdmin4 Installed.${NC}"
        fi
    fi
}

# --- MongoDB Stack ---

install_mongo() {
    if is_installed mongod; then
        echo -e "${GREEN}MongoDB is already installed.${NC}"
    else
        print_msg "Installing MongoDB Server"
        sudo apt-get install -y gnupg curl
        curl -fsSL https://www.mongodb.org/static/pgp/server-8.0.asc | \
           sudo gpg -o /usr/share/keyrings/mongodb-server-8.0.gpg --dearmor --yes
           
        echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-8.0.gpg ] https://repo.mongodb.org/apt/ubuntu $(lsb_release -cs)/mongodb-org/8.0 multiverse" | \
           sudo tee /etc/apt/sources.list.d/mongodb-org-8.0.list
           
        sudo apt-get update -y
        sudo apt-get install -y mongodb-org
        sudo systemctl start mongod
        sudo systemctl enable mongod
        echo -e "${GREEN}MongoDB Installed & Started!${NC}"
    fi

    # GUI Prompt
    if ask_install "MongoDB Compass (GUI)"; then
        if is_installed mongodb-compass; then
            echo -e "${GREEN}MongoDB Compass is already installed.${NC}"
        else
            print_msg "Installing MongoDB Compass"
            wget https://downloads.mongodb.com/compass/mongodb-compass_1.40.4_amd64.deb -O compass.deb
            sudo apt install ./compass.deb -y
            rm compass.deb
            echo -e "${GREEN}Compass Installed.${NC}"
        fi
    fi
}

# --- Redis Stack ---

install_redis() {
    if is_installed redis-server; then
        echo -e "${GREEN}Redis is already installed.${NC}"
    else
        print_msg "Installing Redis Server"
        sudo apt update
        sudo apt install -y redis-server
        sudo systemctl enable redis-server
        sudo systemctl start redis-server
        echo -e "${GREEN}Redis Installed & Started!${NC}"
    fi

    # GUI Prompt
    if ask_install "Racompass (GUI for Redis)"; then
        if is_installed racompass; then
             echo -e "${GREEN}Racompass is already installed.${NC}"
        else
             print_msg "Installing Racompass"
             sudo snap install racompass
             echo -e "${GREEN}Racompass Installed.${NC}"
        fi
    fi
}

# --- Milvus Stack ---

install_milvus() {
    # Check dependencies first
    check_libstdc

    if dpkg -l | grep -q milvus; then
        echo -e "${GREEN}Milvus is already installed.${NC}"
    else
        print_msg "Installing Milvus (Vector DB)"
        
        # Install Alien to convert RPM if needed, or check for DEB.
        # User requested specific RPM link: v2.6.9
        if ! is_installed alien; then
            print_msg "Installing 'alien' to handle RPM packages on Ubuntu"
            sudo apt install alien -y
        fi

        print_msg "Downloading Milvus v2.6.9 (.rpm)"
        wget -O milvus.rpm "https://github.com/milvus-io/milvus/releases/download/v2.6.9/milvus_2.6.9-1_amd64.rpm"
        
        print_msg "Converting RPM to DEB (This may take a minute)..."
        sudo alien milvus.rpm --scripts
        
        # Alien produces a .deb file, typically milvus_2.6.9-2_amd64.deb (version bumps)
        # We find and install it
        local deb_file=$(ls milvus*.deb | head -n 1)
        
        if [ -n "$deb_file" ]; then
            print_msg "Installing $deb_file..."
            sudo dpkg -i "$deb_file"
            sudo apt-get -f install -y
            rm "$deb_file"
        else
            echo -e "${RED}Error: DEB conversion failed.${NC}"
        fi
        
        rm milvus.rpm
        
        # Enable service
        # Note: RPM install might not set up systemd automatically like a native DEB.
        # We might need to check if the service file exists.
        if [ -f /usr/lib/systemd/system/milvus.service ] || [ -f /lib/systemd/system/milvus.service ]; then
             sudo systemctl daemon-reload
             sudo systemctl start milvus
             sudo systemctl enable milvus
             echo -e "${GREEN}Milvus Installed & Started!${NC}"
        else
             echo -e "${YELLOW}Milvus installed, but systemd service might need manual start.${NC}"
        fi
    fi

    # GUI Prompt
    if ask_install "Attu (GUI for Milvus)"; then
        if dpkg -l | grep -q attu; then
            echo -e "${GREEN}Attu is already installed.${NC}"
        else
            print_msg "Installing Attu"
            wget -O attu.deb "https://github.com/zilliztech/attu/releases/download/v2.6.4/attu_2.6.4_amd64.deb"
            sudo apt install ./attu.deb -y
            rm attu.deb
            echo -e "${GREEN}Attu Installed.${NC}"
        fi
    fi
}

# --- Universal GUIs ---

install_universal_guis() {
    print_msg "Checking Universal DB Tools"
    
    if ask_install "DBeaver (Universal SQL Client)"; then
        if is_installed dbeaver-ce; then
            echo -e "${GREEN}DBeaver is already installed.${NC}"
        else
            print_msg "Installing DBeaver"
            sudo snap install dbeaver-ce --classic
            echo -e "${GREEN}DBeaver Installed.${NC}"
        fi
    fi

    if ask_install "Beekeeper Studio (Modern Client)"; then
        if is_installed beekeeper-studio; then
            echo -e "${GREEN}Beekeeper Studio is already installed.${NC}"
        else
            print_msg "Installing Beekeeper Studio"
            sudo snap install beekeeper-studio
            echo -e "${GREEN}Beekeeper Installed.${NC}"
        fi
    fi
}

# --- Main ---

clear
echo -e "${BLUE}${BOLD}Database Stack Setup${NC}"
echo -e "--------------------"
echo -e "Install Servers and their GUIs sequentially.\n"

setup_snap

ask_install "PostgreSQL Stack" && install_postgres
ask_install "MongoDB Stack" && install_mongo
ask_install "Redis Stack" && install_redis
ask_install "Milvus Stack" && install_milvus

echo -e "\n${YELLOW}--- Universal Viewers ---${NC}\n"
install_universal_guis

echo -e "\n${GREEN}Database Setup Complete! 🗄️${NC}\n"
