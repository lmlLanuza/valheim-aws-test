#!/bin/bash

# Update the system and install necessary dependencies
apt-get update -y
apt-get upgrade -y
apt-get install -y curl wget docker.io qemu-user-static

# Start Docker service
systemctl enable --now docker

# Install Valheim Server using Docker
# Pull the Docker image for Valheim server (official or community-maintained image)
docker pull lloesche/valheim-server

# Create a directory to store Valheim server configuration and world data
mkdir -p /home/ubuntu/valheim_data

# Run the Valheim server in Docker, passing the necessary environment variables
docker run -d \
  --name=valheim-server \
  -e "SERVER_NAME=LiamValheimServer" \
  -e "WORLD_NAME=DaTWorld" \
  -e "SERVER_PASSWORD=iloveaaron69" \
  -e "PUBLIC=0" \
  -p 2456:2456/udp \
  -p 2457:2457/udp \
  -p 2458:2458/udp \
  -v /home/ubuntu/valheim_data:/opt/valheim \
  --restart unless-stopped \
  lloesche/valheim-server