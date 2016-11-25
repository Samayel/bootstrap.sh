#!/usr/bin/env sh

apt-get update
apt-get -y dist-upgrade
apt-get -y autoremove
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
./scripts/update-manager
./scripts/unbound

shutdown -r +1
