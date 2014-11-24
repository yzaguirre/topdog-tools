#!/bin/bash
# Transfer a backup file over a VPN mesh network
SERVER=
DBNAME=$1

NCATPORT=55558

BCKP_DIR="/home/pi/backup/${SERVER}/${DBNAME}"
mkdir -p "${BCKP_DIR}"
TIMESTAMP=`date +'%F_%H.%M.%S'` # TIMESTAMP=`date +%F`

BCKP_FILE=${TIMESTAMP}-${DBNAME}-db.sql.bz2

NCAT="/usr/bin/ncat -lp ${NCATPORT}"

$NCAT  > "${BCKP_DIR}/${BCKP_FILE}"
