#!/bin/bash
# example
# ./deploy.sh example.com example email@example.com
DOMAIN=$1
APP_NAME=$2
EMAIL=$3
DB_NAME=$2-mysql
IPADDRESS=$4
mvn package
echo "java.runtime.version=11" > system.properties
[[ $? -eq 0 ]] && echo "system.properties created"
#echo "web: env java -jar `ls target/*.jar`" > Procfile
#[[ $? -eq 0 ]] && echo "Procfile created"

ssh root@$IPADDRESS bash << setup_dokku
dokku plugin:install https://github.com/dokku/dokku-mysql.git mysql
dokku plugin:install https://github.com/dokku/dokku-letsencrypt.git
dokku apps:create $APP_NAME
dokku mysql:create $DB_NAME
dokku mysql:link $DB_NAME $APP_NAME
dokku config:set --no-restart "$APP_NAME" DOKKU_LETSENCRYPT_EMAIL=$EMAIL
dokku domains:add $APP_NAME $DOMAIN
dokku domains:remove $APP_NAME $APP_NAME
dokku letsencrypt:enable $APP_NAME
dokku letsencrypt:auto-renew $APP_NAME
setup_dokku



#MYSQL_ROOT_PASSWORD=$(ssh root@${IPADDRESS} cat /var/lib/dokku/services/mysql/$DB_NAME/ROOTPASSWORD)
git remote add dokku dokku@$IPADDRESS:$APP_NAME
[[ $? -eq 0 ]] && echo "Dokku git remote created. Commit the Procfile and system.properties file and run git push dokku master."
git add Procfile system.properties
git commit -m "feat: Add Procfile and system.properties for deployment"
git push dokku master

