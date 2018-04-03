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
* setup backup
  * duplicity
    * gpg --gen-key
      * Name: duplicity
      * Mail: duplicity@$HOST
      * Pass: KeePass (GPG - $HOST)
    * /bootstrap.sh/externals/duply/duply awsS3 create
    * cp /bootstrap.sh/rootfs/.duply/awsS3/* /root/.duply/awsS3/
    * joe /root/.duply/awsS3/conf
      * GPG_KEY / GPG_PW
      * TARGET
      * AWS_ACCESS_KEY_ID / AWS_SECRET_ACCESS_KEY
    * TODO: cron job
  * apt install automysqlbackup
