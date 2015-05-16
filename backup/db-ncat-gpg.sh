#!/bin/bash
# saves mysql dump and ships it via the network encrypted
# cronjob example:
# 0 0 * * * /usr/local/bin/db-spideroak.sh wp >> $HOME/tmp/db-spideroak.log 2>&1
# 4 0 * * * /usr/local/bin/foobar-spideroak.sh foobar >> $HOME/tmp/foobar-spideroak.log 2>&1
# 6 0 * * * /usr/bin/SpiderOak --batchmode >> $HOME/tmp/SpiderOak.log 2>&1
DBNAME=$1
DBSERVER=
DBUSER=
DBPW=

NCATSERVER=
NCATPORT=

GPG_U="" # pub key
GPG_R="" # pub key

DUMP="/usr/bin/mysqldump -h ${DBSERVER} -e -u ${DBUSER} -p${DBPW} $DBNAME"
GPG="/usr/bin/gpg --yes -seu ${GPG_U} -r ${GPG_R}"
NCAT="/usr/bin/ncat --send-only ${NCATSERVER} ${NCATPORT}"

$DUMP | $GPG | $NCAT
