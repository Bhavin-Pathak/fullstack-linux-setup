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
- DBeaver Community Edition
- Windsurf-ai-IDE

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
- MilvusDB

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
   ./milvus-setup.sh
   ./windsurf-ide-setup.sh
   ./cleaner-safe.sh
   ```

---

## 🧹 System Cleanup (cleaner-safe.sh)

The `cleaner-safe.sh` script performs a safe cleanup of your system by removing unused caches, updating packages, and cleaning temporary files. It preserves important data like projects, OS files, SDKs, Docker volumes, and databases.

### Manual Execution

Run the script interactively:

```bash
./cleaner-safe.sh
```

It will prompt for confirmation before proceeding.

### Automated Execution on System Start/Restart

To run the cleanup automatically on system boot or restart using GNOME autostart (note: the script will prompt for confirmation each time):

1. **Create the autostart directory if it doesn't exist**:

   ```bash
   mkdir -p ~/.config/autostart
   ```

2. **Create the .desktop file**:

   ```bash
   nano ~/.config/autostart/sys-script.desktop
   ```

   Add the following content:

   ```
   [Desktop Entry]
   Type=Application
   Name=System Startup Script
   Comment=Open terminal and run sys-script.sh on startup
   Exec=gnome-terminal -- bash -i -c "sleep 5; /home/bhavin-pathak/Documents/sys-script.sh; echo ''; echo 'Press ENTER to close'; read"
   Terminal=false
   X-GNOME-Autostart-enabled=true
   ```

   **Note:**

   - Replace `/home/bhavin-pathak/Documents/sys-script.sh` with the actual absolute path to your script (e.g., `/home/bhavin-pathak/Downloads/fullstack-linux-setup/cleaner-safe.sh`).
   - The script will prompt for confirmation (y/N) in the terminal window.
   - The `sleep 5` gives the system time to fully start before running the script.

3. **Make the .desktop file executable**:

   ```bash
   chmod +x ~/.config/autostart/sys-script.desktop
   ```

This will run the cleanup script automatically in a terminal window every time you log in to GNOME. The terminal will open, run the script, prompt for confirmation, display the output, and wait for you to press ENTER to close it.

**⚠️ Warning:** Running cleanup on every login may affect system performance. Monitor the output and disable the autostart if necessary by setting `X-GNOME-Autostart-enabled=false` in the .desktop file.

---

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

Close Existing Terminal And Open New Terminal And Run Following Commands If Running Scripts Doesn't Shows Versions

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
