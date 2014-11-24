#!/bin/bash
# cronjob could look like:
# 0 0 * * * /usr/local/bin/wordpress-spideroak.sh wp blog >> /home/ubuntu/ubuntucron.log 2>&1
# 2 0 * * * /usr/local/bin/wordpress-spideroak.sh w2 blo2 >> /home/ubuntu/ubuntucron.log 2>&1
# 4 0 * * * /usr/local/bin/foobar-spideroak.sh foo bar >> /home/ubuntu/ubuntucron.log 2>&1
# 6 0 * * * /usr/bin/SpiderOak --batchmode >> /home/ubuntu/ubuntucron.log 2>&1
DBNAME=$1
DBPW=secret_password
WEBFOLDER=$2  # should modify, assuming dir /var/www

SERVER=ec2tk # should modify with a uid
BCKP_DIR="/home/ubuntu/SpiderOak Hive/backup/${SERVER}/${DBNAME}"
mkdir -p "${BCKP_DIR}"
TIMESTAMP=`date +'%F_%H.%M.%S'` # TIMESTAMP=`date +%F`

BCKP_FILE=${TIMESTAMP}-${DBNAME}-db.sql.bz2.gpg
BCKP_WP=${TIMESTAMP}-${WEBFOLDER}-wp.tar.bz2.gpg

GPG_U="ec2tk"
GPG_R="dvdyzag@opmbx.org"

BZ="/bin/bzip2 -9"
DUMP="/usr/bin/mysqldump -e -u root -p${DBPW} $DBNAME"
TAR="/bin/tar c"
GPG="/usr/bin/gpg --yes --sign -e -u ${GPG_U} -r ${GPG_R} -"

$DUMP | $BZ | $GPG > "${BCKP_DIR}/${BCKP_FILE}"
$TAR /var/www/${WEBFOLDER} | $BZ | $GPG > "${BCKP_DIR}/${BCKP_WP}"
