# Minimal, official Debian base image
FROM debian:bookworm-slim

# ---------------------------
# Avoid interactive prompts
# ---------------------------
ENV DEBIAN_FRONTEND=noninteractive

# ---------------------------
# Install essential dependencies
# ---------------------------
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    gnupg2 \
    ca-certificates \
    fonts-liberation \
    libxss1 \
    libappindicator3-1 \
    libasound2 \
    xdg-utils \
    sudo \
    git \
    xvfb \
    build-essential \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

# ---------------------------
# Install Node.js and npm
# ---------------------------
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    node -v && npm -v

# ---------------------------
# Install Google Chrome
# ---------------------------
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
    apt-get install -y ./google-chrome-stable_current_amd64.deb && \
    rm google-chrome-stable_current_amd64.deb

# ---------------------------
# Set default user (optional, safer)
# ---------------------------
RUN useradd -m gitpod && echo "gitpod ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
USER gitpod
WORKDIR /home/gitpod

# ---------------------------
# Verify installations
# ---------------------------
RUN node -v && npm -v && google-chrome --version
