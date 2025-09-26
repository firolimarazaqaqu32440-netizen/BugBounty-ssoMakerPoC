# ---------------------------
# Use a prebuilt image with Node and Chrome
# ---------------------------
FROM zenika/alpine-chrome:with-node

# ---------------------------
# Avoid interactive prompts
# ---------------------------
ENV DEBIAN_FRONTEND=noninteractive

# ---------------------------
# Install extra essentials if needed
# ---------------------------
USER root
RUN apk add --no-cache \
    git \
    sudo \
    xvfb \
    bash \
    curl \
    wget \
    build-base \
    libappindicator \
    fonts-liberation \
    xdg-utils

# ---------------------------
# Create a non-root user
# ---------------------------
RUN adduser -D gitpod && echo "gitpod ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
USER gitpod
WORKDIR /home/gitpod

# ---------------------------
# Verify installations
# ---------------------------
RUN node -v && npm -v && google-chrome --version && git --version
