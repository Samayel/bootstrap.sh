#!/usr/bin/env sh

apt-get update
apt-get upgrade
apt-get install -y debconf-utils

./scripts/configure-timezone
./scripts/configure-keymap
./scripts/apt

./scripts/ssh
./scripts/joe
./scripts/screen
./scripts/git
./scripts/postfix
./scripts/logcheck

shutdown -r +1
