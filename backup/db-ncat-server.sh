#!/bin/bash
# Receive a transfered backup bz2 file via the network unencrypted (unless proper VPN is used)
# SERVER is used for BCKP_DIR only
SERVER=
DBNAME=$1

NCATPORT=55558

BCKP_DIR="${HOME}/backup/${SERVER}/${DBNAME}"
mkdir -p "${BCKP_DIR}"
TIMESTAMP=`date +'%F_%H.%M.%S'` # TIMESTAMP=`date +%F`
# change file extention as needed
BCKP_FILE=${TIMESTAMP}-${DBNAME}-db.sql.bz2

NCAT="/usr/bin/ncat -4lp ${NCATPORT}"

$NCAT  > "${BCKP_DIR}/${BCKP_FILE}"
