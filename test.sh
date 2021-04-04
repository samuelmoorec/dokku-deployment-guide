#!/bin/bash
# example
# ./deploy.sh example.com example
DOMAIN=$1
APP_NAME=$2
DB_NAME=$2-mysql
MYSQL_ROOT_PASSWORD=""

ssh root@"$DOMAIN" bash <<setup_dokku
MYSQL_ROOT_PASSWORD=cat /var/lib/dokku/services/mysql/${APP_NAME}/ROOTPASSWORD
setup_dokku

echo ${MYSQL_ROOT_PASSWORD}

