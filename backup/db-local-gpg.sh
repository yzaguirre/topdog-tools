#!/bin/bash
# Saves mysql dump to gpg file
# cronjob example:
# 0 0 * * * /usr/local/bin/db-spideroak.sh wp >> $HOME/tmp/db-spideroak.log 2>&1
# 4 0 * * * /usr/local/bin/foobar-spideroak.sh foobar >> $HOME/tmp/foobar-spideroak.log 2>&1
# 6 0 * * * /usr/bin/SpiderOak --batchmode >> $HOME/tmp/SpiderOak.log.log 2>&1
DBNAME=$1
DBUSER=
DBPW=

SERVER=
BCKP_DIR="${HOME}/SpiderOak Hive/backup/${SERVER}/${DBNAME}"
mkdir -p "${BCKP_DIR}"
TIMESTAMP=`date +'%F_%H.%M.%S'` # TIMESTAMP=`date +%F`

BCKP_FILE=${TIMESTAMP}-${DBNAME}-db.sql.gpg

GPG_U="" # pub key
GPG_R="" # pub key

DUMP="/usr/bin/mysqldump -e -u ${DBUSER} -p${DBPW} $DBNAME"
GPG="/usr/bin/gpg --yes -ser ${GPG_R} -u ${GPG_U}"

$DUMP | $GPG > "${BCKP_DIR}/${BCKP_FILE}"
