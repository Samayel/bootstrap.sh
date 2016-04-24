#!/usr/bin/env sh

./scripts/timezone
./scripts/apt

./scripts/ssh
./scripts/joe
./scripts/screen
./scripts/git
./scripts/postfix
./scripts/logcheck

shutdown -r +1
