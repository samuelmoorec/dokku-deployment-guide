#!/bin/bash
# example
# ./deploy.sh example.com example
DOMAIN=$1
ssh root@$DOMAIN bash << setup_dokku
sudo echo hello
dokku apps:list
setup_dokku
#MYSQL_ROOT_PASSWORD=$(ssh root@${DOMAIN} cat /var/lib/dokku/services/mysql/$DB_NAME/ROOTPASSWORD)
#echo $MYSQL_ROOT_PASSWORD