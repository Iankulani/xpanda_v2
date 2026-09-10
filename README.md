# xpanda_v2


<img width="360" height="360" alt="147d1ebd-9080-4fa8-b4ac-83a9356b3c8d" src="https://github.com/user-attachments/assets/742e103a-7a0b-4ef8-a5b3-337ecfbfd00c" />

[![GitHub stars](https://img.shields.io/github/stars/Iankulani/xpanda_v2?style=for-the-badge&logo=github)](https://github.com/Iankulani/xpanda_v2/stargazers)
[![GitHub forks](https://img.shields.io/github/forks/Iankulani/xpanda_v2?style=for-the-badge&logo=github)](https://github.com/Iankulani/xpanda_v2/network)
[![GitHub watchers](https://img.shields.io/github/watchers/Iankulani/xpanda_v2?style=for-the-badge&logo=github)](https://github.com/Iankulani/xpanda_v2/watchers)
[![GitHub contributors](https://img.shields.io/github/contributors/Iankulani/xpanda_v2?style=for-the-badge&logo=github)](https://github.com/Iankulani/xpanda_v2/graphs/contributors)
[![GitHub last commit](https://img.shields.io/github/last-commit/Iankulani/xpanda_v2?style=for-the-badge&logo=git)](https://github.com/Iankulani/xpanda_v2/commits/main)
[![License](https://img.shields.io/badge/license-MIT-green?style=for-the-badge)](LICENSE)
[![Platform](https://img.shields.io/badge/platform-Linux%20%7C%20Windows%20%7C%20macOS-blue?style=for-the-badge&logo=linux&logoColor=white)](https://github.com/Iankulani/xpanda_v2)
[![Python](https://img.shields.io/badge/python-3.x-blue?style=for-the-badge&logo=python&logoColor=white)](https://www.python.org/)



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

# Start xPanda-V2
./xpanda

# Or
python3 xpanda_v2.py

# Show help
🐼> help

# Run a ping
🐼> ping 127.0.0.1

# Run nmap scan
🐼> nmap_quick 192.168.1.1

# Generate traffic
🐼> traffic icmp 192.168.1.1 10

# Start keylogger (F10 to stop)
🐼> keylogger_start

# Web dashboard
# Open http://localhost:5000


# 📚 Commands

Network Commands

Command	Description
ping <target>	Ping a target
nmap_quick <target>	Quick port scan
nmap_full <target>	Full port scan
traceroute <target>	Trace network path
whois <domain>	WHOIS lookup
dns <domain>	DNS lookup
location <ip>	IP geolocation
Security Commands
Command	Description
nikto <target>	Web vulnerability scan
dos_syn <ip> <port> <duration>	SYN flood attack
crack <type> <hash>	Password cracking
arp_spoof <target> <gateway>	ARP spoofing
mac_info <mac>	MAC address info
nat_info	NAT information
Social Engineering
Command	Description
phish_facebook	Facebook phishing page
phish_gmail	Gmail phishing page
phish_start <id>	Start phishing server
phish_creds	View captured credentials
Platform Commands
Command	Description
platform_send <platform> <cmd>	Send command to platform
platform_status	Show platform status
agent_register <name> <ip>	Register agent
System Commands
Command	Description
status	System status
history	Command history
system	System information
threats	Recent threats
report	Security report
help	Help menu



⚙️ Configuration
Configuration is stored in ~/.xpanda/config.json:

json
{
  "version": "2.0.0",
  "auto_start": false,
  "web": {
    "enabled": true,
    "port": 5000,
    "host": "0.0.0.0"
  },
  "keylogger": {
    "enabled": false,
    "hotkey": "f10",
    "upload_interval": 30
  },
  "discord": {
    "enabled": false,
    "token": "",
    "prefix": "!"
  },
  "telegram": {
    "enabled": false,
    "bot_token": "",
    "prefix": "/"
  }
}
🤖 Platform Integrations
Discord
Create a bot at https://discord.com/developers

Get your bot token

Configure in xPanda-V2:

text
🐼> platform_send discord "ping 8.8.8.8"
Telegram
Talk to @BotFather on Telegram

Create a new bot and get the token

Configure in xPanda-V2

Slack
Create a Slack app at https://api.slack.com/apps

Get your bot token

Configure in xPanda-V2

🐳 Docker Deployment
Production Deployment
yaml
# docker-compose.prod.yml
version: '3.8'
services:
  xpanda:
    image: xpanda-v2:2.0.0
    network_mode: host
    cap_add:
      - NET_ADMIN
      - NET_RAW
      - SYS_ADMIN
    volumes:
      - xpanda_data:/home/xpanda/.xpanda
    restart: always
volumes:
  xpanda_data:
bash
docker-compose -f docker-compose.prod.yml up -d
🔄 CI/CD
The project uses GitLab CI/CD with the following stages:

Validate - Lint Python, YAML, Dockerfile

Test - Unit tests, dependency checks, security scans

Build - Docker image build

Security - Trivy, Grype vulnerability scans

Deploy - Staging and production deployment

Environment Variables
Variable	Description
CI_REGISTRY_USER	Docker registry username
CI_REGISTRY_PASSWORD	Docker registry password
SSH_PRIVATE_KEY	SSH private key for deployment
STAGING_HOST	Staging server hostname
PRODUCTION_HOST	Production server hostname
🔧 Troubleshooting
Common Issues
1. Permission denied on raw sockets

bash
# Run with sudo
sudo python3 xpanda_v2.py
2. Missing system tools

bash
# Ubuntu/Debian
sudo apt-get install nmap curl wget netcat-openbsd dnsutils traceroute openssh-client docker.io git nikto hashcat iptables macchanger hping3 tcpdump openssl

# macOS
brew install nmap curl wget netcat bind traceroute openssh docker git nikto hashcat tcpdump openssl
3. Python package errors

bash
# Reinstall dependencies
pip install --force-reinstall -r requirements.txt
4. Docker permission issues

bash
# Add user to docker group
sudo usermod -aG docker $USER
newgrp docker
5. Web dashboard not accessible

bash
# Check firewall
sudo ufw allow 5000
# Or
sudo iptables -A INPUT -p tcp --dport 5000 -j ACCEPT
Getting Help
bash
# Check dependencies
python3 requirements-check.py

# View logs
tail -f ~/.xpanda/xpanda.log

# Run in debug mode
XPANDA_DEBUG=1 python3 xpanda_v2.py












