#!/usr/bin/env bash
[ -f /mnt/memo/newsboat-list.sql ] && line="OR url LIKE '%${@}%'" || line="select title || '.mp3+' || enclosure_url from rss_item where "$'\n'"url LIKE '%$@%'"
echo "${line}" >> /mnt/memo/newsboat-list.sql
