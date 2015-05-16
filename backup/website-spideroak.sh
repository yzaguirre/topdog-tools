#!/bin/bash
# cronjob example:
# 0 0 * * * /usr/local/bin/wordpress-spideroak.sh wp blog >> $HOME/tmp/wordrpress-spideroak.log 2>&1
# 2 0 * * * /usr/local/bin/wordpress-spideroak.sh w2 blo2 >> $HOME/tmp/wordrpress-spideroak.log 2>&1
# 4 0 * * * /usr/local/bin/foobar-spideroak.sh foo bar >> $HOME/tmp/foobar-spideroak.log 2>&1
# 6 0 * * * /usr/bin/SpiderOak --batchmode >> $HOME/tmp/SpiderOak.log 2>&1
DBNAME=$1
DBPW=secret_password
WEBFOLDER=$2  # should modify, assuming dir /var/www

SERVER=ec2tk # should modify with a uid
BCKP_DIR="${HOME}/SpiderOak Hive/backup/${SERVER}/${DBNAME}"
mkdir -p "${BCKP_DIR}"
TIMESTAMP=`date +'%F_%H.%M.%S'` # TIMESTAMP=`date +%F`

BCKP_FILE=${TIMESTAMP}-${DBNAME}-db.sql.gpg
BCKP_WP=${TIMESTAMP}-${WEBFOLDER}-wp.tar.gpg

GPG_U="" # pub key
GPG_R="" # pub key

DUMP="/usr/bin/mysqldump -e -u root -p${DBPW} $DBNAME"
TAR="/bin/tar c"
GPG="/usr/bin/gpg --yes -seu ${GPG_U} -r ${GPG_R}"

$DUMP | $GPG > "${BCKP_DIR}/${BCKP_FILE}"
$TAR /var/www/${WEBFOLDER} | $GPG > "${BCKP_DIR}/${BCKP_WP}"
