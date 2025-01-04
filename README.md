
# Installation Guide for Ubuntu
### Update the system
```
sudo apt update && sudo apt upgrade -y
```

### Install required packages
```
sudo apt install lib32gcc-s1 wget tmux -y
```

### Create a dedicated user for the Valheim server
```
sudo adduser --disabled-login valheim
sudo usermod -aG sudo valheim
sudo su - valheim
```

### Install SteamCMD
```
mkdir ~/steamcmd
cd ~/steamcmd
wget https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz
tar -xvzf steamcmd_linux.tar.gz 
```

### Download the Valheim Dedicated Server
```
./steamcmd.sh 
force_install_dir ./valheim_server
login anonymous
app_update 896660 validate
quit
```

### Confugure the Valheim Server
 NOTE: Remove the `-crossplay` parameter and add `-public 0` instead
```
cd valheim_server
vim start_server.sh
chmod +x start_server.sh
```


### Setup and Run the Valheim Server as a Service
```
sudo vim /etc/systemd/system/valheim-server.service

[Unit]
Description=Valheim Dedicated Server
After=network.target

[Service]
User=valheimuser
WorkingDirectory=/home/valheim/valheim_server
ExecStart=/home/valheim/valheim_server/start_server.sh
Restart=on-failure
TimeoutSec=600
LimitNOFILE=4096

[Install]
WantedBy=multi-user.target
```

### Reload the daemon and configure the service to start on boot
```
sudo systemctl daemon-reload
sudo systemctl enable valheim-server.service
sudo systemctl start valheim-server.service
sudo systemctl status valheim-server.service
```