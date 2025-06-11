#!/bin/bash

echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
echo "!!! EXECUTING START.SH SCRIPT (v3) - INSTALLING DEPENDENCIES AND WGET !!!"
echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"

# 1. Update package list and install dependencies, including wget
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

# 2. Download and Install Google Chrome
echo "🔧 Downloading and Installing Google Chrome..."
wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
apt-get install -y ./google-chrome-stable_current_amd64.deb
rm google-chrome-stable_current_amd64.deb

# 3. Start the Streamlit application
echo "🚀 Starting Streamlit app..."
streamlit run app.py --server.port 8080 --server.address 0.0.0.0
