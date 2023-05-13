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
# Debian comes with adduser installed
sudo adduser server
sudo usermod -aG sudo server

# now we have a safer user to login with
# we now disable root login through ssh
cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak # backup current sshd_config
sed -i 's/PermitRootLogin yes/PermitRootLogin no/g' /etc/ssh/sshd_config # remove root login via ssh
systemctl restart sshd # must restart for changes to take effect

# --- LOCAL ENVIRONMENT CONFIGURATION ---
su - server # login to newly created secure server user
if [[ ! $EUID -ne 0 ]]; then
    echo "Error: 'setup.sh' failed to log into user 'server' from 'root'."
    exit 1
fi

# setup bash config
cd /home
cat .bashrc-extra >> .bashrc # append
rm .bashrc-extra # clean up

# install git
sudo apt update
sudo apt install git

# install my vim config
git clone https://github.com/nickramsay19/.vim

#TODO: install vim plugins
#cd $HOME/.vim/pack/opt
