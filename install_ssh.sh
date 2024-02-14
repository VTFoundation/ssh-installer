#!/bin/bash

# Check if curl is installed
if ! command -v curl &> /dev/null; then
    echo "curl is not installed. Please install curl using the following command:"
    echo "sudo apt-get update && sudo apt-get install -y curl"
    echo "After installing curl, rerun this script to install the SSH server."
    exit 1
fi

# Check if openssh-server is installed
if ! dpkg -l | grep -qw openssh-server; then
    echo "SSH server is not installed. Installing..."
    sudo apt-get update
    sudo apt-get install -y openssh-server
else
    echo "SSH server is already installed."
fi

# Ensure the SSH service is enabled to start on boot
sudo systemctl enable ssh

# Start the SSH service
sudo systemctl start ssh

# Display the status of the SSH service
echo "Checking the status of the SSH service..."
sudo systemctl status ssh --no-pager | head -n 10

echo "SSH server has been installed and started. It will now start on every boot."

