#!/bin/bash
# =====================
# xPanda-V2 Installation Script
# Version: 2.0.0
# For Linux and macOS
# =====================

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'
BOLD='\033[1m'

# Configuration
XPANDA_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VENV_DIR="$XPANDA_DIR/venv"
PYTHON="python3"
PIP="$VENV_DIR/bin/pip"
PYTHON_VENV="$VENV_DIR/bin/python"

# =====================
# Helper Functions
# =====================

print_banner() {
    echo -e "${CYAN}${BOLD}"
    echo "╔══════════════════════════════════════════════════════════╗"
    echo "║     🐼 xPanda-V2 Installation Script v2.0.0             ║"
    echo "║     Ultimate Cybersecurity Command & Control Platform   ║"
    echo "╚══════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
}

log_info() {
    echo -e "${CYAN}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[✅]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[⚠️]${NC} $1"
}

log_error() {
    echo -e "${RED}[❌]${NC} $1"
}

check_command() {
    if command -v "$1" &> /dev/null; then
        return 0
    else
        return 1
    fi
}

detect_os() {
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        if [ -f /etc/debian_version ]; then
            echo "debian"
        elif [ -f /etc/redhat-release ]; then
            echo "redhat"
        elif [ -f /etc/arch-release ]; then
            echo "arch"
        else
            echo "linux"
        fi
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        echo "macos"
    else
        echo "unknown"
    fi
}

# =====================
# Main Installation
# =====================

print_banner

# Check Python
log_info "Checking Python installation..."
if ! check_command python3; then
    log_error "Python 3 is not installed. Please install Python 3.7+"
    exit 1
fi

PYTHON_VERSION=$(python3 --version 2>&1 | awk '{print $2}')
log_success "Found Python $PYTHON_VERSION"

# Check pip
log_info "Checking pip..."
if ! python3 -m pip --version &> /dev/null; then
    log_warning "pip not found. Installing..."
    if check_command apt-get; then
        sudo apt-get install -y python3-pip
    elif check_command brew; then
        brew install python3
    fi
fi
log_success "pip is available"

# Check system dependencies
log_info "Checking system dependencies..."
OS=$(detect_os)
log_info "Detected OS: $OS"

# Install system tools based on OS
install_system_deps() {
    local os=$1
    case $os in
        debian)
            log_info "Installing Debian/Ubuntu packages..."
            sudo apt-get update -qq
            sudo apt-get install -y -qq \
                nmap \
                curl \
                wget \
                netcat-openbsd \
                dnsutils \
                traceroute \
                openssh-client \
                docker.io \
                git \
                nikto \
                hashcat \
                iptables \
                macchanger \
                hping3 \
                tcpdump \
                openssl \
                build-essential \
                python3-dev \
                libssl-dev \
                libffi-dev \
                libpcap-dev \
                libxml2-dev \
                libxslt1-dev \
                zlib1g-dev \
                libjpeg-dev \
                libpng-dev \
                portaudio19-dev \
                python3-tk \
                python3-dev \
                libgirepository1.0-dev \
                gir1.2-gtk-3.0 \
                2>/dev/null || true
            ;;
        redhat)
            log_info "Installing RedHat/CentOS packages..."
            sudo yum install -y \
                nmap \
                curl \
                wget \
                nc \
                bind-utils \
                traceroute \
                openssh-clients \
                docker \
                git \
                nikto \
                hashcat \
                iptables \
                macchanger \
                hping3 \
                tcpdump \
                openssl \
                gcc \
                python3-devel \
                openssl-devel \
                libffi-devel \
                libpcap-devel \
                libxml2-devel \
                libxslt-devel \
                zlib-devel \
                libjpeg-turbo-devel \
                libpng-devel \
                2>/dev/null || true
            ;;
        arch)
            log_info "Installing Arch Linux packages..."
            sudo pacman -S --noconfirm \
                nmap \
                curl \
                wget \
                gnu-netcat \
                bind-tools \
                traceroute \
                openssh \
                docker \
                git \
                nikto \
                hashcat \
                iptables \
                macchanger \
                hping \
                tcpdump \
                openssl \
                base-devel \
                python \
                python-pip \
                libpcap \
                libxml2 \
                libxslt \
                zlib \
                libjpeg-turbo \
                libpng \
                2>/dev/null || true
            ;;
        macos)
            log_info "Installing macOS packages..."
            if ! check_command brew; then
                log_info "Installing Homebrew..."
                /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
            fi
            brew install \
                nmap \
                curl \
                wget \
                netcat \
                bind \
                traceroute \
                openssh \
                docker \
                git \
                nikto \
                hashcat \
                tcpdump \
                openssl \
                libpcap \
                libxml2 \
                libxslt \
                zlib \
                jpeg \
                libpng \
                2>/dev/null || true
            ;;
        *)
            log_warning "Unknown OS. Please install system dependencies manually."
            ;;
    esac
}

# Ask for system dependency installation
read -p "$(echo -e "${CYAN}Install system dependencies? (y/n): ${NC}")" INSTALL_DEPS
if [[ "$INSTALL_DEPS" == "y" || "$INSTALL_DEPS" == "Y" ]]; then
    install_system_deps "$OS"
else
    log_warning "Skipping system dependencies installation"
fi

# Create virtual environment
log_info "Creating virtual environment..."
if [ ! -d "$VENV_DIR" ]; then
    python3 -m venv "$VENV_DIR"
    log_success "Virtual environment created at $VENV_DIR"
else
    log_info "Virtual environment already exists"
fi

# Activate virtual environment
log_info "Activating virtual environment..."
source "$VENV_DIR/bin/activate"

# Upgrade pip
log_info "Upgrading pip..."
pip install --upgrade pip setuptools wheel

# Install Python dependencies
log_info "Installing Python dependencies..."
if [ -f "$XPANDA_DIR/requirements.txt" ]; then
    pip install -r "$XPANDA_DIR/requirements.txt"
    log_success "Python dependencies installed"
else
    log_warning "requirements.txt not found. Installing core dependencies..."
    pip install \
        colorama \
        requests \
        psutil \
        paramiko \
        cryptography \
        flask \
        flask-socketio \
        flask-cors \
        python-socketio \
        scapy \
        dnspython \
        whois \
        matplotlib \
        seaborn \
        numpy \
        reportlab \
        pynput \
        pyautogui \
        pyperclip \
        qrcode \
        pillow \
        pyshorteners \
        google-auth \
        google-api-python-client \
        selenium \
        webdriver-manager \
        pywhatkit \
        discord.py \
        telethon \
        slack-sdk \
        eventlet \
        aiofiles \
        aiohttp \
        rich \
        pandas
fi

# Install optional dependencies
log_info "Installing optional dependencies..."
pip install \
    watchdog \
    pygetwindow \
    pyfiglet \
    art \
    tabulate \
    tqdm \
    python-nmap \
    netifaces \
    netaddr \
    mac-vendor-lookup \
    pyshark \
    impacket \
    pycryptodome \
    bcrypt \
    passlib \
    PyJWT \
    python-dotenv \
    PyYAML \
    toml \
    redis \
    pymongo \
    SQLAlchemy \
    2>/dev/null || true

# Create xpanda directory
log_info "Creating xpanda configuration directory..."
mkdir -p "$HOME/.xpanda"
mkdir -p "$HOME/.xpanda/payloads"
mkdir -p "$HOME/.xpanda/workspaces"
mkdir -p "$HOME/.xpanda/scans"
mkdir -p "$HOME/.xpanda/phishing_pages"
mkdir -p "$HOME/.xpanda/phishing_templates"
mkdir -p "$HOME/.xpanda/captured_credentials"
mkdir -p "$HOME/.xpanda/ssh_keys"
mkdir -p "$HOME/.xpanda/traffic_logs"
mkdir -p "$HOME/.xpanda/nikto_results"
mkdir -p "$HOME/.xpanda/cracking"
mkdir -p "$HOME/.xpanda/arp_logs"
mkdir -p "$HOME/.xpanda/mac_logs"
mkdir -p "$HOME/.xpanda/nat_logs"
mkdir -p "$HOME/.xpanda/keylog_exfil"
mkdir -p "$HOME/.xpanda/docker_scans"
mkdir -p "$HOME/.xpanda/email_composer"
mkdir -p "$HOME/.xpanda/deployments"
mkdir -p "$HOME/.xpanda/domain_hosting"
mkdir -p "$HOME/.xpanda/agents"
mkdir -p "$HOME/.xpanda/c2_logs"
mkdir -p "$HOME/.xpanda/sessions"
mkdir -p "$HOME/.xpanda/web_templates"
mkdir -p "$HOME/.xpanda/modules"
mkdir -p "$HOME/.xpanda/animation_cache"

# Create launcher script
log_info "Creating launcher script..."
cat > "$XPANDA_DIR/xpanda" << 'EOF'
#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VENV_DIR="$SCRIPT_DIR/venv"

if [ -d "$VENV_DIR" ]; then
    source "$VENV_DIR/bin/activate"
fi

if [ -f "$SCRIPT_DIR/xpanda_v2.py" ]; then
    python3 "$SCRIPT_DIR/xpanda_v2.py" "$@"
else
    echo "Error: xpanda_v2.py not found"
    exit 1
fi
EOF
chmod +x "$XPANDA_DIR/xpanda"

# Run dependency check
log_info "Running dependency check..."
if [ -f "$XPANDA_DIR/requirements-check.py" ]; then
    python3 "$XPANDA_DIR/requirements-check.py" || true
fi

# Print completion
echo ""
echo -e "${GREEN}${BOLD}╔══════════════════════════════════════════════════════════╗"
echo "║     🐼 xPanda-V2 Installation Complete!                  ║"
echo "╚══════════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${CYAN}To run xPanda-V2:${NC}"
echo -e "  ${BOLD}cd $XPANDA_DIR${NC}"
echo -e "  ${BOLD}source venv/bin/activate${NC}"
echo -e "  ${BOLD}python3 xpanda_v2.py${NC}"
echo ""
echo -e "  Or use the launcher:"
echo -e "  ${BOLD}./xpanda${NC}"
echo ""
echo -e "${YELLOW}Note: Run with sudo for full functionality (firewall, raw sockets)${NC}"
echo ""