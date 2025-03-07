#!/bin/bash

# Set up the user and home directory variables
USER=jip
UHOME=/home/$USER

# Ensure the directory exists for Nixos config
sudo -u $USER mkdir -p $UHOME/lib/nixos
sudo -u $USER cp -r /tmp/nixos $UHOME/lib/nixos

# Rebuild NixOS with the provided configuration
mv /etc/nixos/configuration.nix /etc/nixos/bak.nix
ln -s $UHOME/lib/nixos/nixos/machines/nixos.nix /etc/nixos/configuration.nix
nixos-rebuild switch --upgrade
nixos-rebuild switch
# Clean up old generations
nix-collect-garbage -d

# Reboot to apply the changes
echo "Post-installation setup completed, rebooting..."
reboot

