#!/usr/bin/env sh

~/bootstrap.sh/scripts/timezone
~/bootstrap.sh/scripts/apt

mkdir ~/tmp
cd ~/tmp

~/bootstrap.sh/scripts/openssh
~/bootstrap.sh/scripts/joe
~/bootstrap.sh/scripts/screen
~/bootstrap.sh/scripts/git
~/bootstrap.sh/scripts/postfix
~/bootstrap.sh/scripts/logcheck

shutdown -r +1
