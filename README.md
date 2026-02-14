# 🚀 Linux Dev Env Bootstrap

**One script to rule them all.**  
Transform a fresh Ubuntu/Debian installation into a **God-tier Development Machine** in minutes.

---

## ⚠️ Requirements

-   **OS**: Ubuntu 22.04 LTS / Debian-based distributions.
-   **Internet**: Required for downloading packages.
-   **Sudo**: Scripts will ask for permission when needed.

---

## ⚡ Quick Start

Forget running 20 commands. Just clone and run **Genesis**:

```bash
git clone https://github.com/Bhavin-Pathak/linux-dev-env-bootstrap.git
cd linux-dev-env-bootstrap
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
| **`ide.sh`** | **IDEs** | VS Code, Cursor, Windsurf, Antigravity, Sublime, Notepad++. |
| **`browsers.sh`** | **Browsers** | Chrome, Edge, Firefox, Brave, Vivaldi, Opera, Chromium, Librewolf, Tor. |
| **`cloud-docker.sh`** | **Docker & Cloud** | AWS, Terraform, K8s, Ansible, Azure, Docker (Desktop/Engine). |
| **`db-tools.sh`** | **Databases & GUIs** | Postgres, Mongo, Redis, Milvus + **GUIs** |
| **`api-test.sh`** | **API Tools** | Postman, Insomnia. |
| **`node-py.sh`** | **Node & Python** | NVM, Node, Yarn, PNPM, Bun, Python 3, Pip, Venv (**Smart Config**). |
| **`flutter.sh`** | **Mobile** | Java 17, Flutter SDK, Dart, Android Studio. |
| **`essentials.sh`** | **Desktop Apps** | Slack, Discord, Zoom, Teams, WhatsApp, Telegram, Spotify, VLC, OBS, Audacity, Blender, Figma, Steam, Flameshot, GParted, Btop. |
| **`cleaner.sh`** | **Maintenance** | 🧹 Deep Clean: Logs, Cache, Trash, Docker Prune. |

---

## 🧠 Smart Features

-   **Shell Detection**: Automatically detects if you use `bash` or `zsh` and updates the correct config file (`.bashrc` / `.zshrc`).
-   **Local Font Support**: `terminal.sh` checks for a local `Hack.zip` before downloading from the internet.
-   **Modular**: Run `genesis.sh` for the menu, or `./docker.sh` if you just want Docker.
-   **Safe Cleaning**: `cleaner.sh` is aggressive but safe. It won't delete your personal files, but it will vacuum system logs and clear caches.

---



---

<div align="center">
  <b>Built for Speed. Built for Devs.</b><br>
  <sub>Happy Coding! 🚀</sub>
</div>
