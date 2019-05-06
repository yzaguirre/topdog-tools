#!/usr/bin/env bash
TIMESTAMP=$(date +'%F_%H.%M.%S')
sqlite3 ~/.newsboat/cache.db < /mnt/memo/newsboat-list.sql > /mnt/memo/dl-${TIMESTAMP}.csv
subl /mnt/memo/dl-${TIMESTAMP}.csv
rm /mnt/memo/newsboat-list.sql