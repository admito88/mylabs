#!/bin/bash
apt upgrade
apt install software-properties-common apt-transport-https wget htop git net-tools -y
wget -q https://packagecloud.io/AtomEditor/atom/gpgkey -O- | sudo apt-key add -
add-apt-repository "deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main"
apt install atom -y
