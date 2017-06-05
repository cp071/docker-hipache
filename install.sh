#!/usr/bin/env bash

echo -e "\\033[0;39mInstallation started ..."
base="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
dirname=$(cd "$base" && echo "${PWD##*/}")


# check existence and copy a customizable file to its destination folder
function copyFile()
{
  file="$1"

  if [ -z "$2" ]
  then
    dir="$base"
    short="$dirname"
  else
    dir="$base/$2"
    short="$dirname/$2"
  fi

  if [ -e "$dir"/"$file" ]
  then
    echo -e "\\033[1;31m- $file already exists in $short: no file copied"
  else
    cp "$base"/default/"$file" "$dir"/"$dest"
    echo -e "\\033[1;32m+ $file copied in $short"
  fi
}

copyFile "config.json" "hipache"
copyFile "docker-compose.yml"

echo -e "\\033[0;39mInstallation completed."