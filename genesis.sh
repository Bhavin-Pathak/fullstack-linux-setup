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
    echo -e "${YELLOW}4.${NC}  Node.js & Python Stack (NVM, Pip, Bun) 🚀"
    echo -e "${YELLOW}5.${NC}  Flutter Stack (Java, Dart, Android Studio) 📱"
    echo -e "${YELLOW}6.${NC}  Docker & Cloud (AWS, K8s, Terraform) 🐳"
    echo -e "${YELLOW}7.${NC}  Databases & GUIs (Mongo, Postgres, Milvus) 🗄️"
    echo -e "${YELLOW}8.${NC}  API Tools (Postman, Insomnia) 🚀"
    echo -e "${YELLOW}9.${NC} Essential Apps (Slack, Spotify, Utils) 🛠️"
    echo -e "${YELLOW}10.${NC} System Cleaner 🧹"
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
        4) ./node-py.sh ;;
        5) ./flutter.sh ;;
        6) ./cloud-docker.sh ;;
        7) ./db-tools.sh ;;
        8) ./api-test.sh ;;
        9) ./essentials.sh ;;
        10) ./cleaner.sh ;;
        0) echo -e "\n${GREEN}Happy Coding! 🚀${NC}"; exit 0 ;;
        *) echo -e "\n${RED}Invalid option. Please try again.${NC}"; sleep 1 ;;
    esac
    
    echo -e "\n${BLUE}Press Enter to return to menu...${NC}"
    read
done
