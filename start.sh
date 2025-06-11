#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
echo "!!! EXECUTING START.SH (v5) - ROBUST ERROR CHECKING !!!"
echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"

# 1. Fix the dpkg state
echo "🔧 Running dpkg --configure -a to fix any broken package states..."
dpkg --configure -a

# 2. Update package list and install dependencies
echo "🔧 Updating apt and installing dependencies..."
apt-get update && apt-get install -y \
    wget \
    libglib2.0-0 \
    libnss3 \
    libfontconfig1 \
    libx11-6 \
    libx11-xcb1 \
    libxcb1 \
    libxcomposite1 \
    libxcursor1 \
    libxdamage1 \
    libxext6 \
    libxfixes3 \
    libxi6 \
    libxrandr2 \
    libxrender1 \
    libxss1 \
    libxtst6 \
    libcups2 \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libgtk-3-0 \
    libgbm1 \
    --no-install-recommends

# 3. Download and Install Google Chrome
echo "🔧 Downloading Google Chrome..."
wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
echo "🔧 Installing Google Chrome from .deb file..."
apt-get install -y ./google-chrome-stable_current_amd64.deb

# 4. Verify Chrome installation
echo "🔧 Verifying Google Chrome installation..."
ls -l /usr/bin/google-chrome

echo "✅ Google Chrome installation verified."
rm google-chrome-stable_current_amd64.deb

# 5. Start the Streamlit application
echo "🚀 Starting Streamlit app..."
streamlit run app.py --server.port 8080 --server.address 0.0.0.0
