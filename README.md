## Remote

BOOTSTRAP_TARGET=root@host ./remote-bootstrap

## Local

* apt-get update
* apt-get install -y screen git
* screen

* git clone --recursive https://github.com/Samayel/bootstrap.sh.git /bootstrap.sh
* cd /bootstrap.sh && ./bootstrap.sh

## Post-Scripts

* Samayel/quyo.net/scripts/*quyo-runall
* Samayel/bootstrap.sh/rootfs/etc/monit/conf-available/quyo-hosts
* https://discovery.cryptosense.com
* johm@shell:~/.ssh/config
* root@bup:/etc/cron.hourly/20-bup-$HOST
