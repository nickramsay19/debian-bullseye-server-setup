#!/bin/bash

# Title: Debian 11 (bullseye) server setup script
# Author: Nicholas Ramsay

# --- ADD SECURE USER ---

# ensure script is ran as root
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root."
    exit 1
fi

# setup a non-root user
sudo adduser server # debian comes with adduser installed

# now we have a safer user to login with
# we now disable root login through ssh
cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak # backup current sshd_config
sed -i 's/PermitRootLogin yes/PermitRootLogin no/g' /etc/ssh/sshd_config # remove root login via ssh
systemctl restart sshd # must restart for changes to take effect

# --- LOCAL ENVIRONMENT CONFIGURATION ---
mkdir -p /home/server # just in case

# install git
sudo apt update
sudo apt install git

# install my vim config
git clone --recurse-submodules https://github.com/nickramsay19/.vim /home/server/.vim

# move our bashrc to the home for later
sudo cp /home/server/.bashrc /home/server/.bashrc.bak # backup
sudo cat /root/debian-bullseye-server-setup/.bashrc-extra >> /home/server/.bashrc # append to the generated (by sudo -i) bashrc

# clean up
sudo rm -rf /root/debian-bullseye-server-setup

# start a new session logged into safe user
su -l server
