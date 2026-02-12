# 🚀 Linux Genesis: The Ultimate Dev Environment

**One script to rule them all.**  
Transform a fresh Ubuntu/Debian installation into a **God-tier Development Machine** in minutes.

---

## ⚡ Quick Start

Forget running 20 commands. Just clone and run **Genesis**:

```bash
git clone https://github.com/Bhavin-Pathak/fullstack-linux-setup.git
cd fullstack-linux-setup
chmod +x *.sh
./genesis.sh
```

**`genesis.sh`** is the master control center. It launches an interactive menu where you can choose exactly what to install.

---

## 🛠️ The Arsenal (Script Inventory)

Every script is standalone, but `genesis.sh` brings them together.

| Script | Purpose | Power Features |
| :--- | :--- | :--- |
| **`genesis.sh`** | **Master Menu** | 🔥 The Origin. Runs all other scripts. |
| **`terminal.sh`** | **Terminal** | **Zsh**, **Powerlevel10k**, **Hack Fonts**, `bat`, `eza`, `fzf`. |
| **`ide.sh`** | **IDEs** | VS Code, Cursor, Windsurf, Sublime, Notepad++. |
| **`browsers.sh`** | **Browsers** | Chrome, Brave, Firefox, Opera. |
| **`communication.sh`** | **Chat** | Slack, Discord, Zoom, Microsoft Teams. |
| **`media.sh`** | **Media** | Spotify, VLC, OBS Studio. |
| **`cloud.sh`** | **DevOps** | AWS CLI, Terraform, Kubectl, Ansible, Azure CLI. |
| **`docker.sh`** | **Containers** | Smart Install: Docker Desktop (GUI) or Engine (CLI). |
| **`db.sh`** | **Databases** | Postgres 16, MongoDB 8, Redis, Milvus. (Dockerized). |
| **`db-view.sh`** | **DB GUIs** | DBeaver, pgAdmin4, Compass, Redis Insight. |
| **`api-test.sh`** | **API Tools** | Postman, Insomnia. |
| **`node.sh`** | **JS Stack** | NVM, Node, Yarn, PNPM (**Smart Config**). |
| **`python.sh`** | **Python** | Python 3, Pip, Venv (**Smart Config**). |
| **`java.sh`** | **Java** | OpenJDK 17 (**Smart Config**). |
| **`flutter.sh`** | **Mobile** | Flutter SDK, Dart, Android Studio. |
| **`utils.sh`** | **Utils** | Flameshot (Screenshots), GParted. |
| **`cleaner.sh`** | **Maintenance** | 🧹 Deep Clean: Logs, Cache, Trash, Docker Prune. |

---

## 🧠 Smart Features

-   **Shell Detection**: Automatically detects if you use `bash` or `zsh` and updates the correct config file (`.bashrc` / `.zshrc`).
-   **Local Font Support**: `terminal.sh` checks for a local `Hack.zip` before downloading from the internet.
-   **Modular**: Run `genesis.sh` for the menu, or `./docker.sh` if you just want Docker.
-   **Safe Cleaning**: `cleaner.sh` is aggressive but safe. It won't delete your personal files, but it will vacuum system logs and clear caches.

---

## ⚠️ Requirements

-   **OS**: Ubuntu 22.04 LTS / Debian-based distributions.
-   **Internet**: Required for downloading packages.
-   **Sudo**: Scripts will ask for permission when needed.

---

<div align="center">
  <b>Built for Speed. Built for Devs.</b><br>
  <sub>Happy Coding! 🚀</sub>
</div>
