#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
echo "!!! EXECUTING START.SH (v6) - LIGHTWEIGHT CHROMIUM ATTEMPT !!!"
echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"

# 1. Fix the dpkg state
echo "🔧 Running dpkg --configure -a to fix any broken package states..."
dpkg --configure -a

# 2. Update package list and install dependencies + lightweight chromium
echo "🔧 Updating apt and installing dependencies..."
apt-get update && apt-get install -y \
    chromium-browser \
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


# 3. Verify Chrome installation
echo "🔧 Verifying Chromium installation..."
ls -l /usr/bin/chromium-browser

echo "✅ Chromium installation verified."

# 4. Start the Streamlit application
echo "🚀 Starting Streamlit app..."
streamlit run app.py --server.port 8080 --server.address 0.0.0.0
