# =====================
# xPanda-V2 Makefile
# Version: 2.0.0
# =====================

.PHONY: help install install-dev clean test lint format build run docker docker-build docker-run docker-stop docker-clean deps check deploy

# Variables
PYTHON := python3
PIP := pip3
VENV := venv
VENV_BIN := $(VENV)/bin
DOCKER_IMAGE := xpanda-v2
DOCKER_TAG := 2.0.0
DOCKER_COMPOSE := docker-compose

# Colors
GREEN := \033[0;32m
YELLOW := \033[1;33m
RED := \033[0;31m
CYAN := \033[0;36m
NC := \033[0m

# =====================
# Help
# =====================
help:
	@echo "$(CYAN)🐼 xPanda-V2 Makefile$(NC)"
	@echo "=========================================="
	@echo ""
	@echo "$(GREEN)Installation:$(NC)"
	@echo "  make install        - Install dependencies"
	@echo "  make install-dev    - Install dev dependencies"
	@echo "  make deps           - Install system dependencies"
	@echo "  make check          - Check dependencies"
	@echo ""
	@echo "$(GREEN)Development:$(NC)"
	@echo "  make test           - Run tests"
	@echo "  make lint           - Run linters"
	@echo "  make format         - Format code"
	@echo "  make clean          - Clean build artifacts"
	@echo ""
	@echo "$(GREEN)Docker:$(NC)"
	@echo "  make docker-build   - Build Docker image"
	@echo "  make docker-run     - Run Docker container"
	@echo "  make docker-stop    - Stop Docker container"
	@echo "  make docker-clean   - Remove Docker resources"
	@echo "  make docker-compose - Run with docker-compose"
	@echo ""
	@echo "$(GREEN)Run:$(NC)"
	@echo "  make run            - Run xPanda-V2"
	@echo "  make run-web        - Run web dashboard only"
	@echo ""

# =====================
# Installation
# =====================
install:
	@echo "$(CYAN)📦 Installing xPanda-V2...$(NC)"
	$(PYTHON) -m venv $(VENV)
	$(VENV_BIN)/pip install --upgrade pip setuptools wheel
	$(VENV_BIN)/pip install -r requirements.txt
	@echo "$(GREEN)✅ Installation complete$(NC)"

install-dev: install
	@echo "$(CYAN)📦 Installing dev dependencies...$(NC)"
	$(VENV_BIN)/pip install pytest pytest-cov pytest-asyncio black flake8 mypy isort pylint
	@echo "$(GREEN)✅ Dev dependencies installed$(NC)"

deps:
	@echo "$(CYAN)🔧 Installing system dependencies...$(NC)"
	@if command -v apt-get >/dev/null 2>&1; then \
		sudo apt-get update && sudo apt-get install -y nmap curl wget netcat-openbsd dnsutils traceroute openssh-client docker.io git nikto hashcat iptables macchanger hping3 tcpdump openssl build-essential python3-dev libssl-dev libffi-dev libpcap-dev; \
	elif command -v brew >/dev/null 2>&1; then \
		brew install nmap curl wget netcat bind traceroute openssh docker git nikto hashcat tcpdump openssl; \
	elif command -v pacman >/dev/null 2>&1; then \
		sudo pacman -S --noconfirm nmap curl wget gnu-netcat bind-tools traceroute openssh docker git nikto hashcat iptables macchanger hping tcpdump openssl base-devel; \
	fi
	@echo "$(GREEN)✅ System dependencies installed$(NC)"

check:
	@echo "$(CYAN)🔍 Checking dependencies...$(NC)"
	$(PYTHON) requirements-check.py || true

# =====================
# Testing
# =====================
test:
	@echo "$(CYAN)🧪 Running tests...$(NC)"
	$(VENV_BIN)/python -m pytest tests/ -v --cov=xpanda_v2 --cov-report=term --cov-report=html
	@echo "$(GREEN)✅ Tests complete$(NC)"

test-unit:
	@echo "$(CYAN)🧪 Running unit tests...$(NC)"
	$(VENV_BIN)/python -m pytest tests/unit/ -v

test-integration:
	@echo "$(CYAN)🧪 Running integration tests...$(NC)"
	$(VENV_BIN)/python -m pytest tests/integration/ -v

# =====================
# Code Quality
# =====================
lint:
	@echo "$(CYAN)🔍 Running linters...$(NC)"
	$(VENV_BIN)/flake8 xpanda_v2.py --max-line-length=120 --statistics || true
	$(VENV_BIN)/pylint xpanda_v2.py --disable=all --enable=E || true
	$(VENV_BIN)/mypy xpanda_v2.py --ignore-missing-imports || true
	@echo "$(GREEN)✅ Linting complete$(NC)"

format:
	@echo "$(CYAN)🎨 Formatting code...$(NC)"
	$(VENV_BIN)/black xpanda_v2.py --line-length=120
	$(VENV_BIN)/isort xpanda_v2.py --profile=black
	@echo "$(GREEN)✅ Formatting complete$(NC)"

security:
	@echo "$(CYAN)🔒 Running security checks...$(NC)"
	$(VENV_BIN)/bandit -r xpanda_v2.py || true
	$(VENV_BIN)/safety check || true
	@echo "$(GREEN)✅ Security checks complete$(NC)"

# =====================
# Build
# =====================
build:
	@echo "$(CYAN)📦 Building package...$(NC)"
	$(VENV_BIN)/python setup.py sdist bdist_wheel
	@echo "$(GREEN)✅ Build complete$(NC)"

# =====================
# Docker
# =====================
docker-build:
	@echo "$(CYAN)🐳 Building Docker image...$(NC)"
	docker build -t $(DOCKER_IMAGE):$(DOCKER_TAG) -t $(DOCKER_IMAGE):latest -f Dockerfile .
	@echo "$(GREEN)✅ Docker image built$(NC)"

docker-run:
	@echo "$(CYAN)🐳 Running Docker container...$(NC)"
	docker run -it --rm \
		--name xpanda-v2 \
		--network host \
		--cap-add NET_ADMIN \
		--cap-add NET_RAW \
		--cap-add SYS_ADMIN \
		-v xpanda_data:/home/xpanda/.xpanda \
		-v $(PWD)/reports:/opt/xpanda/reports \
		$(DOCKER_IMAGE):$(DOCKER_TAG)

docker-run-bg:
	@echo "$(CYAN)🐳 Running Docker container in background...$(NC)"
	docker run -d \
		--name xpanda-v2 \
		--network host \
		--cap-add NET_ADMIN \
		--cap-add NET_RAW \
		--cap-add SYS_ADMIN \
		-v xpanda_data:/home/xpanda/.xpanda \
		-v $(PWD)/reports:/opt/xpanda/reports \
		$(DOCKER_IMAGE):$(DOCKER_TAG)

docker-stop:
	@echo "$(CYAN)🐳 Stopping Docker container...$(NC)"
	docker stop xpanda-v2 || true
	docker rm xpanda-v2 || true
	@echo "$(GREEN)✅ Docker container stopped$(NC)"

docker-clean:
	@echo "$(CYAN)🐳 Cleaning Docker resources...$(NC)"
	docker stop xpanda-v2 || true
	docker rm xpanda-v2 || true
	docker rmi $(DOCKER_IMAGE):$(DOCKER_TAG) || true
	docker rmi $(DOCKER_IMAGE):latest || true
	docker volume rm xpanda_data || true
	@echo "$(GREEN)✅ Docker resources cleaned$(NC)"

docker-compose:
	@echo "$(CYAN)🐳 Running with docker-compose...$(NC)"
	$(DOCKER_COMPOSE) up -d

docker-compose-down:
	@echo "$(CYAN)🐳 Stopping docker-compose...$(NC)"
	$(DOCKER_COMPOSE) down

docker-compose-logs:
	@echo "$(CYAN)📜 Showing docker-compose logs...$(NC)"
	$(DOCKER_COMPOSE) logs -f

# =====================
# Run
# =====================
run:
	@echo "$(CYAN)🐼 Running xPanda-V2...$(NC)"
	$(VENV_BIN)/python xpanda_v2.py

run-interactive:
	@echo "$(CYAN)🐼 Running xPanda-V2 in interactive mode...$(NC)"
	$(VENV_BIN)/python -i xpanda_v2.py

# =====================
# Deployment
# =====================
deploy-staging:
	@echo "$(CYAN)🚀 Deploying to staging...$(NC)"
	docker build -t xpanda-v2:staging .
	docker tag xpanda-v2:staging registry.example.com/xpanda-v2:staging
	docker push registry.example.com/xpanda-v2:staging
	@echo "$(GREEN)✅ Staging deployment complete$(NC)"

deploy-production:
	@echo "$(CYAN)🚀 Deploying to production...$(NC)"
	docker build -t xpanda-v2:production .
	docker tag xpanda-v2:production registry.example.com/xpanda-v2:production
	docker push registry.example.com/xpanda-v2:production
	@echo "$(GREEN)✅ Production deployment complete$(NC)"

# =====================
# Clean
# =====================
clean:
	@echo "$(CYAN)🧹 Cleaning build artifacts...$(NC)"
	find . -type f -name "*.pyc" -delete
	find . -type d -name "__pycache__" -delete
	find . -type d -name "*.egg-info" -exec rm -rf {} + 2>/dev/null || true
	rm -rf build/ dist/ .pytest_cache/ .coverage htmlcov/ .mypy_cache/ .pylint.d/ 2>/dev/null || true
	@echo "$(GREEN)✅ Clean complete$(NC)"

clean-all: clean
	@echo "$(CYAN)🧹 Cleaning everything including venv...$(NC)"
	rm -rf $(VENV) 2>/dev/null || true
	@echo "$(GREEN)✅ Complete clean done$(NC)"