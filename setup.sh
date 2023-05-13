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
sudo usermod -aG sudo server

# now we have a safer user to login with
# we now disable root login through ssh
cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak # backup current sshd_config
sed -i 's/PermitRootLogin yes/PermitRootLogin no/g' /etc/ssh/sshd_config # remove root login via ssh
systemctl restart sshd # must restart for changes to take effect

# --- LOCAL ENVIRONMENT CONFIGURATION ---

# install git
sudo apt update
sudo apt install git

# install my vim config
git clone --recurse-submodules https://github.com/nickramsay19/.vim /home/.vim

# move our bashrc to the home for later
# sudo -i will override /home/.bashrc so append our .bashrc settings later
# first move .bashrc-extra into /home to allow us to read from it without sudo
mv -f /root/debian-bullseye-server-setup/.bashrc-extra /home/.bashrc-extra

# setup new user shell w/ -i
sudo -i -u server bash << EOF
    cd /home

    # setup bash config
    cp /home/.bashrc /home/.bashrc.bak # backup 
    cat /home/.bashrc-extra >> /home/.bashrc # append to the generated (by sudo -i) bashrc
    rm /home/.bashrc-extra # clean up
EOF

