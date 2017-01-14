#!/usr/bin/env bash
###################################
# Backup Hipache database content #
###################################

if [[ "$1" == "" ]] || [[ "$1" == "-h" ]]
then
  echo "usage: ${BASH_SOURCE[0]} path"
  if [[ "$1" != "" ]]
  then
    exit 0
  fi

  exit 1
elif [[ ! -d "$1" ]]
then
  echo "$1 is not a valid path"
  exit 1
fi

docker exec -t redis redis-cli save
docker cp redis:/data/dump.rdb "$1"/hipache.rdb

exit 0