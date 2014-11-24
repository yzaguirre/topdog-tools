#!/bin/bash
DBNAME=$1
DBSERVER=
DBUSER=
PW=

NCATSERVER=
NCATPORT=55558

BZ="/bin/bzip2 -9"
DUMP="/usr/bin/mysqldump -h ${DBSERVER} -e -u ${DBUSER} -p${PW} $DBNAME"
NCAT="/usr/bin/ncat ${NCATSERVER} ${NCATPORT}"
$DUMP | $BZ | $NCAT

