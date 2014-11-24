#!/bin/bash
DBNAME=$1
DBUSER=
DBSERVER=
DBPW=

BCKP_DIR="/home/pi/backup/${SERVER}/${DBNAME}"
mkdir -p "${BCKP_DIR}"
TIMESTAMP=`date +'%F_%H.%M.%S'`

BCKP_FILE=${TIMESTAMP}-${DBNAME}-db.sql.bz2

BZ="/bin/bzip2 -9"
DUMP="/usr/bin/mysqldump -h ${DBSERVER} -e -u ${DBUSER} -p${DBPW} $DBNAME"

$DUMP | $BZ  > "${BCKP_DIR}/${BCKP_FILE}"

