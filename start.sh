
#!/bin/bash
apt-get update
apt-get install -y wget gnupg unzip curl
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
apt install -y ./google-chrome-stable_current_amd64.deb
streamlit run app.py --server.port $PORT --server.address 0.0.0.0
