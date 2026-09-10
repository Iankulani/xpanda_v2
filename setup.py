#!/usr/bin/env python3
"""
xPanda-V2 Setup Script
Version: 2.0.0
"""

from setuptools import setup, find_packages
import os

# Read version from main file
VERSION = "2.0.0"
NAME = "xpanda-v2"
AUTHOR = "Ian Carter Kulani"
AUTHOR_EMAIL = "ian.kulanikulani@gmail.com"
DESCRIPTION = "Cybersecurity Command & Control Platform"
LONG_DESCRIPTION = """
xPanda-V2 is a comprehensive cybersecurity command and control platform
that provides 100+ security tools, multi-platform bot integration,
advanced social engineering capabilities, and real-time monitoring.

Features:
- 100+ Security Commands
- Multi-Platform Bot Integration (Discord, Telegram, Slack, Signal, WhatsApp, etc.)
- Web Interface with Cyberpunk Terminal UI
- Advanced Phishing Suite with 100+ Templates
- SSH Remote Access
- REAL Traffic Generation (ICMP/TCP/UDP/HTTP/DNS/ARP)
- Nikto Web Vulnerability Scanner
- Advanced Keylogger with PDF/Email/HTML Exfiltration
- Password Cracking Engine (Hashcat Integration)
- Social Engineering Suite
- IP Management & Threat Detection
- ARP Spoofing & Network Manipulation
- MAC Address Management
- NAT Information
- AI Transformer Engine
- Terminal Animations
- Multi-Platform Command Execution
- Email Composition & Sending
- PDF Report Generation
- Docker Security Scanning
"""

# Read requirements
def read_requirements():
    requirements_path = os.path.join(os.path.dirname(__file__), 'requirements.txt')
    if os.path.exists(requirements_path):
        with open(requirements_path, 'r', encoding='utf-8') as f:
            return [line.strip() for line in f if line.strip() and not line.startswith('#')]
    return []

# Read README
def read_readme():
    readme_path = os.path.join(os.path.dirname(__file__), 'README.md')
    if os.path.exists(readme_path):
        with open(readme_path, 'r', encoding='utf-8') as f:
            return f.read()
    return LONG_DESCRIPTION

setup(
    name=NAME,
    version=VERSION,
    author=AUTHOR,
    author_email=AUTHOR_EMAIL,
    description=DESCRIPTION,
    long_description=read_readme(),
    long_description_content_type='text/markdown',
    url='https://github.com/iankulanI/xpanda-v2',
    license='MIT',
    packages=find_packages(),
    py_modules=['xpanda_v2'],
    install_requires=read_requirements(),
    python_requires='>=3.7',
    classifiers=[
        'Development Status :: 5 - Production/Stable',
        'Intended Audience :: Developers',
        'Intended Audience :: System Administrators',
        'Intended Audience :: Information Technology',
        'License :: OSI Approved :: MIT License',
        'Operating System :: OS Independent',
        'Programming Language :: Python :: 3',
        'Programming Language :: Python :: 3.7',
        'Programming Language :: Python :: 3.8',
        'Programming Language :: Python :: 3.9',
        'Programming Language :: Python :: 3.10',
        'Programming Language :: Python :: 3.11',
        'Programming Language :: Python :: 3.12',
        'Topic :: Security',
        'Topic :: System :: Networking',
        'Topic :: System :: Systems Administration',
        'Topic :: Utilities',
    ],
    entry_points={
        'console_scripts': [
            'xpanda=xpanda_v2:main',
        ],
    },
    package_data={
        '': ['*.txt', '*.md', '*.json', '*.yml', '*.yaml'],
    },
    include_package_data=True,
    zip_safe=False,
    keywords='cybersecurity security hacking pentesting network monitoring',
    project_urls={
        'Bug Reports': 'https://github.com/iankulani/xpanda-v2/issues',
        'Source': 'https://github.com/iankulani/xpanda_v2',
        'Documentation': 'https://github.com/iankulani/xpanda-v2/wiki',
    },
)