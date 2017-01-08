# Hipache reverse proxy 

## Goal

Hipache is a distributed http and websocket proxy. Its capability to support key-value databases (i.e. Redis) for storing vhost configurations allows to update thew without restart.  
This composition of containers provides an hipache container, a redis container for vhost configurations storage and a bash script for easily update configurations.

## Requirements

This composition of containers uses an external network named proxy for communicate with non exposed sites on this network. You must create it if it doesn't exist:
```
$ docker network create proxy
```

## Usage

Up the composition:
```
$ docker-compose up -d
```

Create an nginx or apache instance on the hipache network:
```
$ docker run --network hipache -d some-image-of-a-front-container # Don't expose the port
```

Associate the internal ip (for instance 172.17.0.5) of the front instance to a domain name (www.mydomain.com:
(see hipache documentation)
```
$ docker exec -t redis redis-cli rpush frontend:www.mydomain.com mywebsite # mywebsite is an arbitrary name for design the website
$ docker exec -t redis redis-cli rpush frontend:www.mydomain.com http://172.17.0.5
```

For easily handle website IPs, you can use my hipache-ips.sh bash script in [my script repository](https://github.com/l-vo/scripts)

## Third-party containers used:
* https://github.com/hipache/hipache
* https://github.com/docker-library/redis