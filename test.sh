#!/bin/bash
# example
# ./deploy.sh example.com example
DOMAIN=$1
APP_NAME=$2
DB_NAME=$2_db

#ssh root@${DOMAIN} bash <<setup_dokku
#pwd
#cd /var/lib/dokku/services/mysql/${DB_NAME}
#pwd
#ls
#cat ROOTPASSWORD
#MYSQL_ROOT_PASSWORD=$(< ROOTPASSWORD)
#setup_dokku

MYSQL_ROOT_PASSWORD=$(ssh root@${DOMAIN} cat /var/lib/dokku/services/mysql/$DB_NAME/ROOTPASSWORD)

echo $MYSQL_ROOT_PASSWORD

