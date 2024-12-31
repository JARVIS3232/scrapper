#!/usr/bin/env bash

# Update package lists
apt-get update

# Install necessary dependencies for running Chrome
apt-get install -y \
    wget \
    unzip \
    libxss1 \
    libappindicator3-1 \
    libgdk-pixbuf2.0-0 \
    libnss3 \
    libatk-bridge2.0-0 \
    libatk1.0-0 \
    libgbm1 \
    libasound2 \
    libnspr4 \
    libxcomposite1 \
    libxrandr2 \
    libxi6 \
    libxtst6 \
    xdg-utils \
    fonts-liberation \
    libappindicator1 \
    libindicator7 \
    libdbusmenu-glib4 \
    libdbusmenu-gtk3-4 \
    ca-certificates \
    fonts-dejavu \
    libxdamage1 \
    libgdk-pixbuf2.0-0

# Install Google Chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
dpkg -i google-chrome-stable_current_amd64.deb
apt-get install -f -y  # Fix missing dependencies if any

# Install ChromeDriver
CHROME_VERSION=$(google-chrome --version | awk '{print $3}')
wget https://chromedriver.storage.googleapis.com/${CHROME_VERSION}/chromedriver_linux64.zip
unzip chromedriver_linux64.zip -d /usr/local/bin/

# Clean up downloaded files
rm google-chrome-stable_current_amd64.deb
rm chromedriver_linux64.zip
