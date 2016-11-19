#!/bin/bash

if [[ "$1" == "" ]]
then
  echo "Usage ${BASH_SOURCE[0]} domain"
  echo "domain is the domain of the site without http:://" 
  exit 1
fi

docker exec -t redis redis-cli LRANGE frontend:"$1" 0 0 | cut -d " " -f 2 | cut -d "\"" -f 2

exit 0
