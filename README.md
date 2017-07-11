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
* bup@shell:~/bin/bup/20-bup-$HOST
** ~bup/.ssh/config
** ssh $HOST 'bup init' (validate hostkey + initialize bup)
