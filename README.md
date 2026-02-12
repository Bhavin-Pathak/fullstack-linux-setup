# 🚀 Fullstack Linux Setup

Ready-to-use installation scripts for quickly setting up a complete development environment on **Ubuntu/Debian-based Linux systems**.  
Includes programming languages, databases, container tools, IDEs, and system maintenance utilities.

---

## 📋 Script Inventory

| Script | Purpose | Key Features |
| :--- | :--- | :--- |
| **`>_ ide.sh`** | IDE Installer | VS Code, Cursor, Antigravity, Windsurf, Sublime Text & More. Interactive menu. |
| **`>_ browsers.sh`** | Web Browsers | Chrome, Brave, Firefox, Opera, Chromium. Interactive menu. |
| **`>_ db.sh`** | Database Servers | PostgreSQL 16, MongoDB 8, Redis, Milvus. Interactive menu. |
| **`>_ db-view.sh`** | Database GUIs | DBeaver, pgAdmin4, MongoDB Compass, Redis Insight. |
| **`>_ api-test.sh`** | API Tools | Postman, Insomnia. |
| **`>_ docker.sh`** | Containerization | Smart Install: Docker Desktop (GUI) or Docker Engine (CLI). |
| **`>_ node.sh`** | JavaScript Stack | NVM, Node LTS, Yarn, PNPM, Bun. **Smart Shell Config** (zsh/bash). |
| **`>_ python.sh`** | Python Stack | Python 3, Pip, Venv. **Smart Shell Config** (zsh/bash). |
| **`>_ java.sh`** | Java Stack | OpenJDK 17. **Smart Shell Config** (JAVA_HOME). |
| **`>_ flutter.sh`** | Mobile Stack | Flutter SDK, Dart, Android Studio. **Smart Shell Config**. |
| **`>_ cleaner.sh`** | System Maintenance | Safe Cleanup: Logs (>3d), Cache, Trash, Docker Prune. |

---

## ⚙️ How to Use

### 1. Clone the Repository

```bash
git clone https://github.com/Bhavin-Pathak/fullstack-linux-setup.git
cd fullstack-linux-setup
chmod +x *.sh
```

### 2. Run a Script

Simply execute the script you need. For example, to set up your IDEs:

```bash
./ide.sh
```

Or to set up your Node.js environment:

```bash
./node.sh
```

---

## 🧹 System Cleanup

The `cleaner.sh` script is a powerful maintenance tool. It safely removes:
-   Unused Apt/Snap packages
-   Old System Logs (Vacuum > 3 days)
-   Browser & IDE Caches
-   Docker artifacts (prune unused containers/images)
-   User Trash & Temp files

```bash
./cleaner.sh
```

---

## 🔍 Verification

After installation, the scripts automatically configure your environment. For languages (Node, Python, Flutter, Java), you may need to reload your shell:

```bash
source ~/.bashrc  # Or source ~/.zshrc
```

Verify installations:

```bash
node -v
python3 --version
java -version
docker --version
```

---

## ⚠️ Notes

-   **OS**: Designed for Ubuntu 22.04 LTS or compatible Debian-based distros.
-   **Permissions**: Scripts will request `sudo` access where necessary.
-   **Smart Config**: Language scripts detect your shell (`bash` vs `zsh`) and update the correct config file automatically.
