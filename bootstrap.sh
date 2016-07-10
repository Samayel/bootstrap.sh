#!/usr/bin/env sh

apt-get update
apt-get -y upgrade
apt-get -y install debconf-utils

./scripts/configure-timezone
./scripts/configure-keymap
./scripts/fix-hosts
./scripts/apt

./scripts/ssh
./scripts/joe
./scripts/screen
./scripts/git
./scripts/postfix
./scripts/logrotate
./scripts/logcheck
./scripts/monit
./scripts/swapfile

shutdown -r +1
