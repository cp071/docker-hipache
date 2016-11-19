#!/bin/bash

if [[ "$2" == "" ]]
then
  echo "Usage ${BASH_SOURCE[0]} domain ip"
  echo "domain is the domain of the site without http:://" 
  echo "ip is the new ip of the container"
  exit 1
fi

name=$(docker exec -t redis redis-cli LRANGE frontend:"$1" 0 0 | cut -d " " -f 2 | cut -d "\"" -f 2)

if [[ "$name" == "" ]]
then
  echo "Error: can't find container name for $1"
  exit 1
else
  docker exec -t redis redis-cli LINSERT frontend:"$1" AFTER "$name" "http://$2" >/dev/null
  docker exec -t redis redis-cli RPOP frontend:"$1" >/dev/null
fi

exit 0
