#!/bin/bash
set -e

# Colors
BLUE='\033[1;34m'
GREEN='\033[1;32m'
RED='\033[1;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}🔹Updating package list...${NC}"
sudo apt update -y 
echo -e "${GREEN}Updating Package list completed ${NC}"

echo -e "${BLUE}🔹Installing Java 17 OpenJDK...${NC}"
sudo apt install -y openjdk-17-jdk
echo -e "${GREEN}Installing Java-17 with OpenJDK complete ${NC}"

echo -e "${BLUE}🔹Setting JAVA_HOME and updating PATH...${NC}"
echo 'export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64' >> ~/.bashrc
echo 'export PATH=$JAVA_HOME/bin:$PATH' >> ~/.bashrc
echo -e "${GREEN}Setting JAVA_HOME and updating PATH completed ${NC}"

echo -e "${BLUE}🔹Reloading bashrc to apply changes...${NC}"
source ~/.bashrc
echo -e "${GREEN}Reloading bashrc completed ${NC}"

echo -e "${BLUE}🔹Verifying Version of Java...${NC}"
java --version

echo -e "${RED}if JAVA_HOME is not updated in current session, try running 'source ~/.bashrc' manually.${NC}"

