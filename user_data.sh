#!/bin/bash
sudo apt update && sudo apt upgrade -y
sudo apt install -y wget curl unzip tar lib32gcc-s1

# Install SteamCMD
mkdir -p ~/steamcmd && cd ~/steamcmd
wget https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz
tar -xvzf steamcmd_linux.tar.gz

# Download Valheim server
~/steamcmd/steamcmd.sh +login anonymous +force_install_dir ~/valheim +app_update 896660 validate +quit

# Create a startup script
cat <<EOF >~/valheim/start_valheim.sh
#!/bin/bash
cd ~/valheim
./valheim_server.x86_64 -name "${var.valheim_server_name}" \
  -port 2456 -world "${var.world_name}" -password "${var.server_password}" -public 1
EOF
chmod +x ~/valheim/start_valheim.sh

# Start the server
~/valheim/start_valheim.sh