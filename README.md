# 🚀 Linux Development Environment Setup

This repository provides **ready-to-use installation scripts** for quickly setting up a complete development environment on **Ubuntu/Debian-based Linux systems**.  
It includes programming languages, frameworks, runtimes, databases, container tools, IDEs, and browsers.

---

## 📋 Prerequisites

Before running the scripts, ensure:

- 🐧 **OS:** Ubuntu 22.04 LTS (or compatible Debian-based system)
- 🔑 **Privileges:** `sudo` access is required
- 🌐 **Internet:** Stable connection to fetch packages and snaps

---

## 📦 What Gets Installed?

### 🖥️ Development Tools

- Android Studio
- Visual Studio Code
- Postman
- Beekeeper Studio

### 💻 Programming & Runtimes

- Node.js (via NVM)
- npm, Yarn, pnpm (via Corepack)
- Bun runtime
- Nodemon
- Java 17 (OpenJDK)
- Flutter SDK + Dart

### 🗄️ Databases

- MongoDB 8.0 (auto-start enabled)
- PostgreSQL (via official PGDG repo)

### 🐳 Containers

- Docker Engine
- Docker CLI
- Containerd runtime
- Docker Compose plugin

### 🌍 Browsers

- Brave Browser
- Opera Browser

---

## 📂 Scripts Overview

| Category          | Script File                        | Description                                                              |
| ----------------- | ---------------------------------- | ------------------------------------------------------------------------ |
| Development Tools | `development-tools-setup-linux.sh` | Installs Android Studio, VS Code, Postman, Beekeeper Studio              |
| Flutter & Dart    | `flutter-dart-setup-linux.sh`      | Installs Flutter SDK & Dart, and also updates in system environment PATH |
| Browsers          | `browsers-setup-linux.sh`          | Installs Brave & Opera                                                   |
| MongoDB           | `mongodb-setup-linux.sh`           | Installs MongoDB, starts service, enables on boot                        |
| PostgreSQL        | `postgresql-setup-linux.sh`        | Installs PostgreSQL from PGDG repository                                 |
| Node.js & Tools   | `node-tools-setup-linux.sh`        | Installs Node.js (NVM), Yarn, pnpm, Bun, Nodemon                         |
| Java              | `java17-setup-linux.sh`            | Installs OpenJDK 17 and sets JAVA_HOME in system environment             |
| Docker            | `docker-setup-linux.sh`            | Installs Docker Engine, CLI, Compose plugin                              |

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
   ./development-tools-setup-linux.sh
   ```

3. **Run other scripts as needed**
   ```bash
   ./flutter-dart-setup-linux.sh
   ./browsers-setup-linux.sh
   ./node-tools-setup-linux.sh
   ./mongodb-setup-linux.sh
   ./postgresql-setup-linux.sh
   ./java17-setup-linux.sh
   ./docker-setup-linux.sh
   ```

---

## 🔍 Verification

Run the following commands to verify installation:

```bash
# Node & Package Managers
node -v
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
- MongoDB and PostgreSQL are **enabled on boot**.
- Docker Desktop `.deb` package must be downloaded manually:  
  👉 [Download Docker Desktop](https://docs.docker.com/desktop/setup/install/linux/ubuntu/)
