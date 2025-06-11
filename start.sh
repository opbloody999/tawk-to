#!/bin/bash

# Install Chrome
echo "🔧 Installing Chrome..."
wget -q -O chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
apt-get update
apt install -y ./chrome.deb
rm chrome.deb
which google-chrome

# Start Streamlit app
echo "🚀 Starting app..."
streamlit run app.py --server.port 8080 --server.address 0.0.0.0
