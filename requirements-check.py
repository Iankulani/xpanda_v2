#!/usr/bin/env python3
"""
xPanda-V2 Dependency Checker
Version: 2.0.0
Verifies all required and optional dependencies are installed.
"""

import sys
import os
import subprocess
import importlib
from typing import Dict, List, Tuple, Optional

# ANSI Colors
GREEN = '\033[92m'
YELLOW = '\033[93m'
RED = '\033[91m'
CYAN = '\033[96m'
RESET = '\033[0m'
BOLD = '\033[1m'

# =====================
# DEPENDENCY DEFINITIONS
# =====================

REQUIRED_PACKAGES = {
    'colorama': 'colorama',
    'requests': 'requests',
    'psutil': 'psutil',
    'paramiko': 'paramiko',
    'cryptography': 'cryptography',
    'flask': 'flask',
    'flask_socketio': 'flask-socketio',
    'flask_cors': 'flask-cors',
    'socketio': 'python-socketio',
    'scapy': 'scapy',
    'dns': 'dnspython',
    'whois': 'whois',
    'matplotlib': 'matplotlib',
    'seaborn': 'seaborn',
    'numpy': 'numpy',
    'reportlab': 'reportlab',
    'pynput': 'pynput',
    'pyautogui': 'pyautogui',
    'pyperclip': 'pyperclip',
    'qrcode': 'qrcode',
    'PIL': 'pillow',
    'pyshorteners': 'pyshorteners',
    'google.oauth2': 'google-auth',
    'googleapiclient': 'google-api-python-client',
    'selenium': 'selenium',
    'webdriver_manager': 'webdriver-manager',
    'pywhatkit': 'pywhatkit',
    'discord': 'discord.py',
    'telethon': 'telethon',
    'slack_sdk': 'slack-sdk',
    'eventlet': 'eventlet',
    'aiofiles': 'aiofiles',
    'aiohttp': 'aiohttp',
    'rich': 'rich',
    'pandas': 'pandas',
}

OPTIONAL_PACKAGES = {
    'watchdog': 'watchdog',
    'pygetwindow': 'pygetwindow',
    'pyfiglet': 'pyfiglet',
    'art': 'art',
    'tabulate': 'tabulate',
    'tqdm': 'tqdm',
    'python-nmap': 'python-nmap',
    'netifaces': 'netifaces',
    'netaddr': 'netaddr',
    'mac-vendor-lookup': 'mac-vendor-lookup',
    'pyshark': 'pyshark',
    'impacket': 'impacket',
    'pycryptodome': 'pycryptodome',
    'bcrypt': 'bcrypt',
    'passlib': 'passlib',
    'jwt': 'PyJWT',
    'dotenv': 'python-dotenv',
    'yaml': 'PyYAML',
    'toml': 'toml',
    'redis': 'redis',
    'pymongo': 'pymongo',
    'sqlalchemy': 'SQLAlchemy',
}

SYSTEM_TOOLS = [
    ('ping', 'Network connectivity testing'),
    ('nmap', 'Network scanning'),
    ('curl', 'HTTP requests'),
    ('wget', 'File downloads'),
    ('nc', 'Netcat network utility'),
    ('dig', 'DNS lookups'),
    ('traceroute', 'Network path tracing'),
    ('ssh', 'Secure shell'),
    ('docker', 'Container management'),
    ('git', 'Version control'),
    ('nikto', 'Web vulnerability scanner'),
    ('hashcat', 'Password cracking'),
    ('signal-cli', 'Signal messaging'),
    ('iptables', 'Firewall management'),
    ('macchanger', 'MAC address spoofing'),
    ('hping3', 'Packet crafting'),
    ('tcpdump', 'Packet capture'),
    ('openssl', 'Cryptography toolkit'),
]


class DependencyChecker:
    def __init__(self):
        self.required_ok = 0
        self.required_missing = 0
        self.optional_ok = 0
        self.optional_missing = 0
        self.tools_ok = 0
        self.tools_missing = 0
        self.missing_required = []
        self.missing_optional = []
        self.missing_tools = []

    def check_python_version(self) -> bool:
        """Check Python version >= 3.7"""
        version = sys.version_info
        if version.major >= 3 and version.minor >= 7:
            print(f"{GREEN}✅ Python {version.major}.{version.minor}.{version.micro}{RESET}")
            return True
        else:
            print(f"{RED}❌ Python {version.major}.{version.minor} - Requires Python 3.7+{RESET}")
            return False

    def check_package(self, module_name: str, package_name: str) -> bool:
        """Check if a Python package is installed"""
        try:
            importlib.import_module(module_name)
            return True
        except ImportError:
            return False

    def check_tool(self, tool: str) -> bool:
        """Check if a system tool is available"""
        from shutil import which
        return which(tool) is not None

    def check_required(self) -> Tuple[int, int]:
        """Check all required packages"""
        print(f"\n{BOLD}{CYAN}📦 Required Python Packages:{RESET}")
        print("=" * 50)
        
        for module, package in REQUIRED_PACKAGES.items():
            if self.check_package(module, package):
                print(f"  {GREEN}✅ {package}{RESET}")
                self.required_ok += 1
            else:
                print(f"  {RED}❌ {package} (missing){RESET}")
                self.required_missing += 1
                self.missing_required.append(package)
        
        return self.required_ok, self.required_missing

    def check_optional(self) -> Tuple[int, int]:
        """Check all optional packages"""
        print(f"\n{BOLD}{CYAN}📦 Optional Python Packages:{RESET}")
        print("=" * 50)
        
        for module, package in OPTIONAL_PACKAGES.items():
            if self.check_package(module, package):
                print(f"  {GREEN}✅ {package}{RESET}")
                self.optional_ok += 1
            else:
                print(f"  {YELLOW}⚠️ {package} (optional){RESET}")
                self.optional_missing += 1
                self.missing_optional.append(package)
        
        return self.optional_ok, self.optional_missing

    def check_system_tools(self) -> Tuple[int, int]:
        """Check all system tools"""
        print(f"\n{BOLD}{CYAN}🔧 System Tools:{RESET}")
        print("=" * 50)
        
        for tool, description in SYSTEM_TOOLS:
            if self.check_tool(tool):
                print(f"  {GREEN}✅ {tool} - {description}{RESET}")
                self.tools_ok += 1
            else:
                print(f"  {YELLOW}⚠️ {tool} - {description} (not found){RESET}")
                self.tools_missing += 1
                self.missing_tools.append(tool)
        
        return self.tools_ok, self.tools_missing

    def generate_install_command(self) -> str:
        """Generate pip install command for missing required packages"""
        if not self.missing_required:
            return ""
        return f"pip install {' '.join(self.missing_required)}"

    def print_summary(self):
        """Print final summary"""
        print(f"\n{BOLD}{CYAN}{'=' * 50}{RESET}")
        print(f"{BOLD}{CYAN}📊 DEPENDENCY SUMMARY{RESET}")
        print(f"{BOLD}{CYAN}{'=' * 50}{RESET}")
        
        total_required = self.required_ok + self.required_missing
        total_optional = self.optional_ok + self.optional_missing
        total_tools = self.tools_ok + self.tools_missing
        
        print(f"\n  {BOLD}Required Packages:{RESET}")
        print(f"    ✅ Installed: {GREEN}{self.required_ok}{RESET}/{total_required}")
        print(f"    ❌ Missing:   {RED}{self.required_missing}{RESET}/{total_required}")
        
        print(f"\n  {BOLD}Optional Packages:{RESET}")
        print(f"    ✅ Installed: {GREEN}{self.optional_ok}{RESET}/{total_optional}")
        print(f"    ⚠️ Missing:   {YELLOW}{self.optional_missing}{RESET}/{total_optional}")
        
        print(f"\n  {BOLD}System Tools:{RESET}")
        print(f"    ✅ Installed: {GREEN}{self.tools_ok}{RESET}/{total_tools}")
        print(f"    ⚠️ Missing:   {YELLOW}{self.tools_missing}{RESET}/{total_tools}")
        
        if self.missing_required:
            print(f"\n  {BOLD}{RED}🔴 Missing Required Packages:{RESET}")
            for pkg in self.missing_required:
                print(f"    • {pkg}")
            print(f"\n  {BOLD}To install missing required packages:{RESET}")
            print(f"    {CYAN}{self.generate_install_command()}{RESET}")
        
        if self.missing_optional:
            print(f"\n  {BOLD}{YELLOW}🟡 Missing Optional Packages:{RESET}")
            for pkg in self.missing_optional:
                print(f"    • {pkg}")
            print(f"\n  {BOLD}To install missing optional packages:{RESET}")
            print(f"    {CYAN}pip install {' '.join(self.missing_optional)}{RESET}")
        
        if self.missing_tools:
            print(f"\n  {BOLD}{YELLOW}🟡 Missing System Tools:{RESET}")
            for tool in self.missing_tools:
                print(f"    • {tool}")
            print(f"\n  {BOLD}Installation hints:{RESET}")
            print(f"    {CYAN}Ubuntu/Debian: sudo apt-get install {' '.join(self.missing_tools)}{RESET}")
            print(f"    {CYAN}macOS:         brew install {' '.join(self.missing_tools)}{RESET}")
            print(f"    {CYAN}Windows:       choco install {' '.join(self.missing_tools)}{RESET}")
        
        print(f"\n{BOLD}{CYAN}{'=' * 50}{RESET}")
        
        if self.required_missing == 0:
            print(f"{GREEN}{BOLD}✅ All required dependencies are installed!{RESET}")
            return True
        else:
            print(f"{RED}{BOLD}❌ Some required dependencies are missing.{RESET}")
            return False


def main():
    """Main entry point"""
    print(f"""
{CYAN}{BOLD}╔══════════════════════════════════════════════════════════╗
║     🐼 xPanda-V2 Dependency Checker v2.0.0               ║
╚══════════════════════════════════════════════════════════╝{RESET}
""")
    
    checker = DependencyChecker()
    
    # Check Python version
    print(f"{BOLD}{CYAN}🐍 Python Version:{RESET}")
    print("=" * 50)
    python_ok = checker.check_python_version()
    
    if not python_ok:
        print(f"\n{RED}❌ Python 3.7+ is required. Please upgrade Python.{RESET}")
        sys.exit(1)
    
    # Run all checks
    checker.check_required()
    checker.check_optional()
    checker.check_system_tools()
    
    # Print summary
    success = checker.print_summary()
    
    # Exit code
    sys.exit(0 if success else 1)


if __name__ == "__main__":
    main()