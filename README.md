# 🚀 Development Environment Setup

This repository provides **ready-to-use installation scripts** for quickly setting up a complete development environment on **Ubuntu/Debian-based Linux systems**.  
It includes programming languages, frameworks, runtimes, databases, container tools, IDEs, and browsers.

---

## 📋 Prerequisites

Before running the scripts, ensure:

- 🐧 **OS:** Ubuntu 22.04 LTS (or compatible Debian-based system)
- 🔑 **Privileges:** `sudo` access is required
- 🌐 **Internet:** Stable connection to fetch packages and snaps
- 📦 **Snap:** Make sure snapd is installed on your system. if not then run `sudo apt install snapd -y`

---

### 🖥️ Development Tools

- Android Studio
- Visual Studio Code
- Sublime Text
- Notepad++
- Postman
- Beekeeper Studio

### 💻 Programming & Runtimes

- Node.js (via NVM)
- Python3 & Pip
- npm, Yarn, pnpm (via Corepack)
- Bun runtime
- Nodemon
- Java 17 (OpenJDK)
- Flutter SDK + Dart

### 🗄️ Databases

- MongoDB (auto-start enabled)
- PostgreSQL (via official PGDG repo)

### 🐳 Containers

- Docker Engine
- Docker CLI
- Containerd runtime
- Docker Compose plugin

### 🌍 Browsers

- Brave
- Opera
- Chromium
- Firefox

---

## ⚙️ How to Use

1. **Clone the repository**

   ```bash
   git clone https://github.com/Bhavin-Pathak/fullstack-linux-setup.git
   cd fullstack-linux-setup
   chmod +x *.sh
   ```

2. **Run a script (example: Development Tools)**

   ```bash
   ./dev-tools.sh
   ```

3. **Run other scripts as needed**
   ```bash
   ./flutter-dart-setup.sh
   ./browsers-setup.sh
   ./node-tools-setup.sh
   ./mongoDB-setup.sh
   ./postgresql-setup.sh
   ./java17-setup.sh
   ./docker-setup.sh
   ./python-pip-setup.sh
   ```

---

## ⚠️ Important Notes

- After installing **Flutter/Dart** or **Node.js**, restart your terminal or run:
  ```bash
  source ~/.bashrc
  ```
- To check services:
  ```bash
  sudo systemctl status mongod
  sudo systemctl status postgresql
  ```
- MongoDB and PostgreSQL are **enabled on system boot**.

---

## 🔍 Verification

Close Existing Terminal And Open New Terminal And Run Following Commands

```bash
# Node & Package Managers
node -v
nvm -v
npm -v
yarn -v
pnpm -v
bun -v

# Java
java --version

# Flutter & Dart
flutter --version
dart --version

# Databases
psql --version
mongod --version

# Docker
docker --version
docker compose version

# Python & Pip
python --version
pip --version
```

---

## 🚫 Contribution Policy

- This repository does not accept contributions.

- Pull requests will not be merged issues and feature requests are not tracked.

- You are free to clone this repository and modify the scripts locally as per your requirements.
