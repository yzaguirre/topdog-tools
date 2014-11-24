#!/bin/bash
# cronjob could look like:
# 0 0 * * * /usr/local/bin/db-spideroak.sh wp >> /home/ubuntu/ubuntucron.log 2>&1
# 4 0 * * * /usr/local/bin/foobar-spideroak.sh foobar >> /home/ubuntu/ubuntucron.log 2>&1
# 6 0 * * * /usr/bin/SpiderOak --batchmode >> /home/ubuntu/ubuntucron.log 2>&1
DBNAME=$1
DBUSER=
DBPW=

SERVER=ec2tk
BCKP_DIR="/home/ubuntu/SpiderOak Hive/backup/${SERVER}/${DBNAME}"
mkdir -p "${BCKP_DIR}"
TIMESTAMP=`date +'%F_%H.%M.%S'` # TIMESTAMP=`date +%F`

BCKP_FILE=${TIMESTAMP}-${DBNAME}-db.sql.bz2.gpg

GPG_U="ec2tk"
GPG_R="dvdyzag@opmbx.org"

BZ="/bin/bzip2 -9"
DUMP="/usr/bin/mysqldump -e -u ${DBUSER} -p${DBPW} $DBNAME"
GPG="/usr/bin/gpg --yes --sign -e -u ${GPG_U} -r ${GPG_R} -"

$DUMP | $BZ | $GPG > "${BCKP_DIR}/${BCKP_FILE}"
