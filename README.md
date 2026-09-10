# xpanda_v2

Xpanda


# 🐼 xPanda-V2

**Ultimate Cybersecurity Command & Control Platform**

Version: 2.0.0 | Author: Ian Carter Kulani, MSc

---

## 📋 Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Quick Start](#quick-start)
- [Installation](#installation)
  - [Linux/macOS](#linuxmacos)
  - [Windows](#windows)
  - [Docker](#docker)
- [Usage](#usage)
- [Commands](#commands)
- [Configuration](#configuration)
- [Platform Integrations](#platform-integrations)
- [Docker Deployment](#docker-deployment)
- [CI/CD](#cicd)
- [Troubleshooting](#troubleshooting)
- [License](#license)

---

## 🎯 Overview

xPanda-V2 is a comprehensive cybersecurity command and control platform
that provides 100+ security tools, multi-platform bot integration, advanced
social engineering capabilities, and real-time monitoring.

---

## ✨ Features

- **100+ Security Commands**
- **Multi-Platform Bot Integration** (Discord, Telegram, Slack, Signal, WhatsApp, Google Chat, iMessage)
- **Web Interface** with Cyberpunk Terminal UI
- **Advanced Phishing Suite** with 100+ Templates
- **SSH Remote Access** via All Platforms
- **REAL Traffic Generation** (ICMP/TCP/UDP/HTTP/DNS/ARP)
- **Nikto Web Vulnerability Scanner**
- **Advanced Keylogger** with PDF/Email/HTML Exfiltration
- **Password Cracking Engine** (Hashcat Integration)
- **Social Engineering Suite** with 100+ Phishing Templates
- **IP Management & Threat Detection**
- **ARP Spoofing & Network Manipulation**
- **MAC Address Management**
- **NAT Information**
- **AI Transformer Engine**
- **Terminal Animations**
- **Multi-Platform Command Execution**
- **Email Composition & Sending**
- **PDF Report Generation**
- **Docker Security Scanning**

---

## 🚀 Quick Start

### One-line Install (Linux/macOS)

```bash
curl -fsSL https://raw.githubusercontent.com/iankulani/xpanda_v2/main/install.sh | bash
```

# 📦 Installation
Linux/macOS

# Clone repository
```bash
git clone https://github.com/iankulani/xpanda_v2.git
cd xpanda_v2
```

# Run installation script
```bash
chmod +x install.sh
./install.sh
```

# Or manual installation

```bash
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
```

# Run
```bash
python3 xpanda_v2.py
```

Windows


# REM Clone repository

```bash
git clone https://github.com/iankulani/xpanda_v2.git
cd xpanda-v2
```

# REM Run installation script
```bash
install.bat
```

# REM Or manual installation
```bash
python -m venv venv
venv\Scripts\activate
pip install -r requirements.txt
```
      
# REM Run
```bash
python xpanda_v2.py
```

# Docker

# Build image
```bash
docker build -t xpanda-v2:2.0.0 .
```

# Run container
```bash
docker run -it --rm \
  --name xpanda-v2 \
  --network host \
  --cap-add NET_ADMIN \
  --cap-add NET_RAW \
  --cap-add SYS_ADMIN \
  -v xpanda_data:/home/xpanda/.xpanda \
  xpanda-v2:2.0.0
```


# Start all services
```bash
docker-compose up -d
```

# View logs
docker-compose logs -f

# Stop
docker-compose down


