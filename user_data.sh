#!/bin/bash
# Update the system and install necessary packages
apt-get update -y
apt-get install -y wget curl tar lib32gcc1 libssl-dev

# Create a directory for the Valheim server
mkdir -p /home/ubuntu/valheim
cd /home/ubuntu/valheim

# Download the Valheim server files (via SteamCMD, the official method)
wget https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz

# Extract SteamCMD and install Valheim server
tar -xvzf steamcmd_linux.tar.gz

# Install Valheim using SteamCMD
./steamcmd.sh +login anonymous +force_install_dir /home/ubuntu/valheim +app_update 896660 validate +quit

# Create a script to start the Valheim server
cat > /home/ubuntu/valheim/start_valheim_server.sh << 'EOF'
#!/bin/bash
# Start the Valheim server
./valheim_server.x86_64 -name "MyValheimServer" -port 2456 -world "MyWorld" -password "yourpassword" -public 1
EOF

# Make the start script executable
chmod +x /home/ubuntu/valheim/start_valheim_server.sh

# Start the Valheim server in the background
nohup /home/ubuntu/valheim/start_valheim_server.sh &

# Optionally, you can print the server status
echo "Valheim server is starting..."