#!/bin/sh

# Install rclone if not installed already
sudo pacman -S --needed --noconfirm rclone || exit $?

echo "Please, call the new remote 'onedrive' (case-sensitive)"
rclone config || exit $?

# Path for the new service and the OneDrive folder
servfile=/etc/systemd/system/onedrive.service
onepath="${HOME}/OneDrive"

# Create the folder in which to mount OneDrive
mkdir $onepath

# TODO: Test if rclone works at this point before creating the service

# Create the service file
echo -e "[Unit]\nDescription=Mount the OneDrive folder\nAfter=network.target\nStartLimitIntervalSec=0\n\n[Service]\nType=simple\nRestart=always\nRestartSec=10\nUser=${USERNAME}\nExecStart=/bin/rclone --vfs-cache-mode writes mount onedrive: ${onepath}\n\n[Install]\nWantedBy=multi-user.target\n" | sudo tee -a $servfile

# Enable the service
sudo systemctl enable --now onedrive.service

# Open the folder in the file explorer
xdg-open $onepath

echo "Finished successfully!"
