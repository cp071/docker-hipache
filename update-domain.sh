#!/bin/bash

#################################################
## Update ip of the website of a given project ##
#################################################

function redis_cli()
{
    # Use tr because redis-cli output non printable characters at the end of the line
    docker exec -t redis redis-cli --raw $1 | tr -dc "[[:print:]]"
}

if [[ "$2" == "" ]]
then
  echo "Usage ${BASH_SOURCE[0]} project ip [domain]"
  echo "project is the name of the project"
  echo "ip is the new ip of the container"
  exit 1
fi

if [[ $(redis_cli "EXISTS frontend:$1") == 0 ]]
then
  echo "No registered domain found for project $1"
  question="Domain (domain of the site without http:://):"
  echo "$question"
  read domain

  while [[ "$domain" == "" ]] || [[ "$domain" =~ ^http:// ]]
  do
    echo "Empty domain or domain starting by http:// entered"
    echo "$question"
    read domain
  done
  redis_cli "SET frontend:$1 $domain"
else
  domain=$(redis_cli "GET frontend:$1")
fi


if [[ $(redis_cli "EXISTS frontend:$domain") == 0 ]]
then
  redis_cli "RPUSH frontend:$domain $1"
  redis_cli "RPUSH frontend:$domain http://$2"
else
  name=$(redis_cli LRANGE frontend:"$domain" 0 0 | cut -d " " -f 2 | cut -d "\"" -f 2)
  redis_cli "LINSERT frontend:$domain AFTER $1 http://$2" >/dev/null
  redis_cli "RPOP frontend:$domain" >/dev/null
fi


exit 0
