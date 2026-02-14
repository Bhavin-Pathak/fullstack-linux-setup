#!/bin/bash
# Author: Bhavin Pathak
# Description: Genesis Script - The Origin of Your Dev Environment

# Styling
BOLD='\033[1m'
BLUE='\033[1;34m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
RED='\033[1;31m'
NC='\033[0m'

# Ensure scripts are executable
chmod +x *.sh

show_menu() {
    clear
    echo -e "${BLUE}${BOLD}🚀 Fullstack Linux Setup 🚀${NC}"
    echo -e "---------------------------------"
    echo -e "Select a setup to run:"
    echo -e "---------------------------------"
    echo -e "${YELLOW}1.${NC}  Terminal (Zsh, Hack Fonts, P10k) 🎨"
    echo -e "${YELLOW}2.${NC}  IDEs (VS Code, Cursor, Windsurf) 💻"
    echo -e "${YELLOW}3.${NC}  Browsers (Chrome, Brave, Firefox) 🌐"
    echo -e "${YELLOW}4.${NC}  Node.js Stack (NVM, Yarn, Bun) 🟩"
    echo -e "${YELLOW}5.${NC}  Python Stack (Pip, Venv) 🐍"
    echo -e "${YELLOW}6.${NC}  Java Stack (OpenJDK 17) ☕"
    echo -e "${YELLOW}7.${NC}  Flutter Stack (Dart, Android Studio) 📱"
    echo -e "${YELLOW}8.${NC}  Docker & Cloud (AWS, K8s, Terraform) 🐳"
    echo -e "${YELLOW}9.${NC}  Databases (Mongo, Postgres, Redis) 🗄️"
    echo -e "${YELLOW}10.${NC} DB GUIs (DBeaver, Compass) 👁️"
    echo -e "${YELLOW}11.${NC} API Tools (Postman, Insomnia) 🚀"
    echo -e "${YELLOW}12.${NC} Communication (Slack, Discord, Zoom) 💬"
    echo -e "${YELLOW}13.${NC} Media (Spotify, VLC, OBS) 🎬"
    echo -e "${YELLOW}14.${NC} Utilities (Flameshot, GParted) 🛠️"
    echo -e "${YELLOW}15.${NC} System Cleaner 🧹"
    echo -e "---------------------------------"
    echo -e "${RED}0. Exit${NC}"
    echo -e "---------------------------------"
}

while true; do
    show_menu
    read -p "Enter your choice: " choice
    
    case $choice in
        1) ./terminal.sh ;;
        2) ./ide.sh ;;
        3) ./browsers.sh ;;
        4) ./node.sh ;;
        5) ./python.sh ;;
        6) ./java.sh ;;
        7) ./flutter.sh ;;
        8) ./cloud-docker.sh ;;
        9) ./db.sh ;;
        10) ./db-view.sh ;;
        11) ./api-test.sh ;;
        12) ./communication.sh ;;
        13) ./media.sh ;;
        14) ./utils.sh ;;
        15) ./cleaner.sh ;;
        0) echo -e "\n${GREEN}Happy Coding! 🚀${NC}"; exit 0 ;;
        *) echo -e "\n${RED}Invalid option. Please try again.${NC}"; sleep 1 ;;
    esac
    
    echo -e "\n${BLUE}Press Enter to return to menu...${NC}"
    read
done
