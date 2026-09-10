@echo off
REM =====================
REM xPanda-V2 Installation Script
REM Version: 2.0.0
REM For Windows
REM =====================

setlocal EnableDelayedExpansion

REM Configuration
set "XPANDA_DIR=%~dp0"
set "VENV_DIR=%XPANDA_DIR%venv"
set "PYTHON=python"
set "PIP=%VENV_DIR%\Scripts\pip.exe"
set "PYTHON_VENV=%VENV_DIR%\Scripts\python.exe"

REM Colors (Windows 10+)
set "GREEN=[92m"
set "YELLOW=[93m"
set "RED=[91m"
set "CYAN=[96m"
set "NC=[0m"
set "BOLD=[1m"

REM =====================
REM Banner
REM =====================
echo %CYAN%%BOLD%
echo ============================================================
echo      xPanda-V2 Installation Script v2.0.0
echo      Ultimate Cybersecurity Command ^& Control Platform
echo ============================================================
echo %NC%

REM =====================
REM Check Python
REM =====================
echo %CYAN%[INFO]%NC% Checking Python installation...

python --version >nul 2>&1
if errorlevel 1 (
    echo %RED%[ERROR]%NC% Python is not installed or not in PATH
    echo Please install Python 3.7+ from https://python.org
    pause
    exit /b 1
)

for /f "tokens=2" %%i in ('python --version 2^>^&1') do set PYTHON_VERSION=%%i
echo %GREEN%[OK]%NC% Found Python %PYTHON_VERSION%

REM Check pip
echo %CYAN%[INFO]%NC% Checking pip...
python -m pip --version >nul 2>&1
if errorlevel 1 (
    echo %YELLOW%[WARN]%NC% pip not found. Installing...
    python -m ensurepip --upgrade
)

echo %GREEN%[OK]%NC% pip is available

REM =====================
REM Check for admin rights
REM =====================
net session >nul 2>&1
if errorlevel 1 (
    echo %YELLOW%[WARN]%NC% Not running as administrator
    echo Some features may not work properly
    echo For full functionality, run as administrator
) else (
    echo %GREEN%[OK]%NC% Running as administrator
)

REM =====================
REM Check for Chocolatey
REM =====================
where choco >nul 2>&1
if errorlevel 1 (
    echo %YELLOW%[WARN]%NC% Chocolatey not found
    echo Some system tools may need to be installed manually
) else (
    echo %GREEN%[OK]%NC% Chocolatey is available
)

REM =====================
REM Install system dependencies
REM =====================
set /p INSTALL_DEPS="%CYAN%Install system dependencies? (y/n): %NC%"
if /i "%INSTALL_DEPS%"=="y" (
    echo %CYAN%[INFO]%NC% Installing system dependencies...
    
    where choco >nul 2>&1
    if errorlevel 1 (
        echo %YELLOW%[WARN]%NC% Chocolatey not available. Please install manually:
        echo   - nmap: https://nmap.org/download.html
        echo   - curl: https://curl.se/windows/
        echo   - wget: https://eternallybored.org/misc/wget/
        echo   - netcat: https://eternallybored.org/misc/netcat/
        echo   - openssh: https://www.openssh.com/
        echo   - docker: https://docs.docker.com/desktop/windows/
        echo   - git: https://git-scm.com/download/win
    ) else (
        choco install -y nmap curl wget netcat openssh docker-desktop git nikto hashcat 2>nul
    )
) else (
    echo %YELLOW%[WARN]%NC% Skipping system dependencies installation
)

REM =====================
REM Create virtual environment
REM =====================
echo %CYAN%[INFO]%NC% Creating virtual environment...

if not exist "%VENV_DIR%" (
    python -m venv "%VENV_DIR%"
    echo %GREEN%[OK]%NC% Virtual environment created at %VENV_DIR%
) else (
    echo %CYAN%[INFO]%NC% Virtual environment already exists
)

REM Activate virtual environment
echo %CYAN%[INFO]%NC% Activating virtual environment...
call "%VENV_DIR%\Scripts\activate.bat"

REM =====================
REM Upgrade pip
REM =====================
echo %CYAN%[INFO]%NC% Upgrading pip...
python -m pip install --upgrade pip setuptools wheel

REM =====================
REM Install Python dependencies
REM =====================
echo %CYAN%[INFO]%NC% Installing Python dependencies...

if exist "%XPANDA_DIR%requirements.txt" (
    pip install -r "%XPANDA_DIR%requirements.txt"
    echo %GREEN%[OK]%NC% Python dependencies installed
) else (
    echo %YELLOW%[WARN]%NC% requirements.txt not found. Installing core dependencies...
    pip install colorama requests psutil paramiko cryptography flask flask-socketio flask-cors python-socketio scapy dnspython whois matplotlib seaborn numpy reportlab pynput pyautogui pyperclip qrcode pillow pyshorteners google-auth google-api-python-client selenium webdriver-manager pywhatkit discord.py telethon slack-sdk eventlet aiofiles aiohttp rich pandas
)

REM =====================
REM Install optional dependencies
REM =====================
echo %CYAN%[INFO]%NC% Installing optional dependencies...
pip install watchdog pygetwindow pyfiglet art tabulate tqdm python-nmap netifaces netaddr mac-vendor-lookup pyshark impacket pycryptodome bcrypt passlib PyJWT python-dotenv PyYAML toml redis pymongo SQLAlchemy 2>nul

REM =====================
REM Create xpanda directory
REM =====================
echo %CYAN%[INFO]%NC% Creating xpanda configuration directory...

set "XPANDA_HOME=%USERPROFILE%\.xpanda"
mkdir "%XPANDA_HOME%" 2>nul
mkdir "%XPANDA_HOME%\payloads" 2>nul
mkdir "%XPANDA_HOME%\workspaces" 2>nul
mkdir "%XPANDA_HOME%\scans" 2>nul
mkdir "%XPANDA_HOME%\phishing_pages" 2>nul
mkdir "%XPANDA_HOME%\phishing_templates" 2>nul
mkdir "%XPANDA_HOME%\captured_credentials" 2>nul
mkdir "%XPANDA_HOME%\ssh_keys" 2>nul
mkdir "%XPANDA_HOME%\traffic_logs" 2>nul
mkdir "%XPANDA_HOME%\nikto_results" 2>nul
mkdir "%XPANDA_HOME%\cracking" 2>nul
mkdir "%XPANDA_HOME%\arp_logs" 2>nul
mkdir "%XPANDA_HOME%\mac_logs" 2>nul
mkdir "%XPANDA_HOME%\nat_logs" 2>nul
mkdir "%XPANDA_HOME%\keylog_exfil" 2>nul
mkdir "%XPANDA_HOME%\docker_scans" 2>nul
mkdir "%XPANDA_HOME%\email_composer" 2>nul
mkdir "%XPANDA_HOME%\deployments" 2>nul
mkdir "%XPANDA_HOME%\domain_hosting" 2>nul
mkdir "%XPANDA_HOME%\agents" 2>nul
mkdir "%XPANDA_HOME%\c2_logs" 2>nul
mkdir "%XPANDA_HOME%\sessions" 2>nul
mkdir "%XPANDA_HOME%\web_templates" 2>nul
mkdir "%XPANDA_HOME%\modules" 2>nul
mkdir "%XPANDA_HOME%\animation_cache" 2>nul

REM =====================
REM Create launcher script
REM =====================
echo %CYAN%[INFO]%NC% Creating launcher script...

(
echo @echo off
echo setlocal
echo set "SCRIPT_DIR=%%~dp0"
echo set "VENV_DIR=%%SCRIPT_DIR%%venv"
echo.
echo if exist "%%VENV_DIR%%\Scripts\activate.bat" (
echo     call "%%VENV_DIR%%\Scripts\activate.bat"
echo )
echo.
echo if exist "%%SCRIPT_DIR%%xpanda_v2.py" (
echo     python "%%SCRIPT_DIR%%xpanda_v2.py" %%*
echo ) else (
echo     echo Error: xpanda_v2.py not found
echo     exit /b 1
echo )
) > "%XPANDA_DIR%xpanda.bat"

REM =====================
REM Run dependency check
REM =====================
echo %CYAN%[INFO]%NC% Running dependency check...
if exist "%XPANDA_DIR%requirements-check.py" (
    python "%XPANDA_DIR%requirements-check.py"
)

REM =====================
REM Completion
REM =====================
echo.
echo %GREEN%%BOLD%
echo ============================================================
echo      xPanda-V2 Installation Complete!
echo ============================================================
echo %NC%
echo %CYAN%To run xPanda-V2:%NC%
echo   cd %XPANDA_DIR%
echo   venv\Scripts\activate
echo   python xpanda_v2.py
echo.
echo   Or use the launcher:
echo   xpanda.bat
echo.
echo %YELLOW%Note: Run as Administrator for full functionality%NC%
echo.

pause