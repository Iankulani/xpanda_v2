# =====================
# xPanda-V2 Dockerfile
# Version: 2.0.0
# Multi-stage build for optimized image
# =====================

# =====================
# Stage 1: Builder
# =====================
FROM python:3.11-slim AS builder

LABEL maintainer="Ian Carter Kulani"
LABEL version="2.0.0"
LABEL description="xPanda-V2 - Ultimate Cybersecurity Command & Control Platform"

WORKDIR /build

# Install build dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    g++ \
    make \
    libssl-dev \
    libffi-dev \
    libpcap-dev \
    libxml2-dev \
    libxslt1-dev \
    zlib1g-dev \
    libjpeg-dev \
    libpng-dev \
    portaudio19-dev \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir --upgrade pip setuptools wheel && \
    pip install --no-cache-dir -r requirements.txt

# =====================
# Stage 2: Runtime
# =====================
FROM python:3.11-slim

LABEL maintainer="Ian Carter Kulani"
LABEL version="2.0.0"
LABEL description="xPanda-V2 - Ultimate Cybersecurity Command & Control Platform"

# Set environment variables
ENV PYTHONUNBUFFERED=1
ENV PYTHONDONTWRITEBYTECODE=1
ENV DEBIAN_FRONTEND=noninteractive
ENV XPANDA_HOME=/opt/xpanda
ENV PATH="/opt/xpanda:${PATH}"

# Install runtime dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    # Networking tools
    nmap \
    curl \
    wget \
    netcat-openbsd \
    dnsutils \
    traceroute \
    openssh-client \
    # Security tools
    nikto \
    hashcat \
    iptables \
    macchanger \
    hping3 \
    tcpdump \
    openssl \
    # Utilities
    git \
    vim \
    nano \
    htop \
    procps \
    net-tools \
    iputils-ping \
    iproute2 \
    # Python runtime
    libpcap0.8 \
    libxml2 \
    libxslt1.1 \
    zlib1g \
    libjpeg62-turbo \
    libpng16-16 \
    # GUI support (for headless)
    xvfb \
    libx11-6 \
    libxext6 \
    libxrender1 \
    libxtst6 \
    libxi6 \
    && rm -rf /var/lib/apt/lists/*

# Create xpanda user
RUN useradd -m -s /bin/bash -G sudo xpanda && \
    echo "xpanda ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Create app directory
WORKDIR /opt/xpanda

# Copy Python packages from builder
COPY --from=builder /usr/local/lib/python3.11/site-packages/ /usr/local/lib/python3.11/site-packages/
COPY --from=builder /usr/local/bin/ /usr/local/bin/

# Copy application files
COPY xpanda_v2.py .
COPY requirements-check.py .

# Create xpanda directories
RUN mkdir -p /home/xpanda/.xpanda/{payloads,workspaces,scans,phishing_pages,phishing_templates,captured_credentials,ssh_keys,traffic_logs,nikto_results,cracking,arp_logs,mac_logs,nat_logs,keylog_exfil,docker_scans,email_composer,deployments,domain_hosting,agents,c2_logs,sessions,web_templates,modules,animation_cache} && \
    mkdir -p /opt/xpanda/reports && \
    chown -R xpanda:xpanda /home/xpanda/.xpanda /opt/xpanda

# Create launcher script
RUN echo '#!/bin/bash\n\
cd /opt/xpanda\n\
python3 xpanda_v2.py "$@"' > /opt/xpanda/xpanda && \
    chmod +x /opt/xpanda/xpanda && \
    chown xpanda:xpanda /opt/xpanda/xpanda

# Switch to xpanda user
USER xpanda

# Set working directory
WORKDIR /opt/xpanda

# Expose ports
EXPOSE 5000 8080 4444 8443

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD python3 -c "import socket; s=socket.socket(); s.connect(('localhost', 5000)); s.close()" || exit 1

# Volume for persistent data
VOLUME ["/home/xpanda/.xpanda", "/opt/xpanda/reports"]

# Default command
ENTRYPOINT ["/opt/xpanda/xpanda"]
CMD ["--help"]