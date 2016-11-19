# Hipache reverse proxy 

## Requirements

This composition of containers uses an external network named proxy for communicate with non exposed sites on this network. You must create it if it doesn't exist:
```
$ docker network create --name=proxy
```
