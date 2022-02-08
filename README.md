## Remote

BOOTSTRAP_TARGET=root@host ./remote-bootstrap

## Local

* apt-get update
* apt-get install -y screen git
* screen

* git clone --recursive https://github.com/Samayel/bootstrap.sh.git /bootstrap.sh
* cd /bootstrap.sh && ./bootstrap.sh

## Post-Scripts

* check/fix hostname
* update quyo.net/scripts/*quyo-runall
* update bootstrap.sh/rootfs/etc/monit/conf-available/quyo-hosts
* update ~/.ssh/config
* setup checkmk
* optional
  * install tarsnap (./scripts/tarsnap)
  * take back control from systemd networking (./scripts/disable-systemd-networking)
  * ClouDNS Monitoring

## Setup backup

* apt install automysqlbackup
* duplicity
  * gpg --gen-key
    * Name: duplicity
    * Mail: duplicity@$HOST
    * Pass: KeePass (GPG - $HOST)
  * /bootstrap.sh/externals/duply/duply awsS3 create
  * cp /bootstrap.sh/homefs/.duply/awsS3/* /root/.duply/awsS3/
  * ln -sf /bootstrap.sh/homefs/.duply/awsS3/exclude --target-directory=/root/.duply/awsS3/
  * joe /root/.duply/awsS3/conf
    * GPG_KEY / GPG_PW
    * TARGET
    * AWS_ACCESS_KEY_ID / AWS_SECRET_ACCESS_KEY
  * /bootstrap.sh/externals/duply/duply awsS3 status
  * tar czf "/root/tmp/duply-awsS3-$(hostname).tar.gz" /root/.duply/awsS3/
    * add to KeePass
  * ln -sf /bootstrap.sh/rootfs/etc/cron.daily/duplicity --target-directory=/etc/cron.daily
  * ln -sf /bootstrap.sh/rootfs/etc/cron.weekly/duplicity --target-directory=/etc/cron.weekly
