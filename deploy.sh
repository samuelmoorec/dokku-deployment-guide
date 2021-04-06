#!/bin/bash
# example
# ./deploy.sh example.com example email@example.com
DOMAIN=$1
APP_NAME=$2
EMAIL=$3
DB_NAME=$2-mysql
IPADDRESS=$4

echo "TESTING MAVEN project..."
mvn package
if [ $? -ne 0 ]; then
    echo "mvn package -> FAILED"
    echo "Please make necessary changes to application to ensure that the application can build properly"
    echo "If you have TESTS please make sure those pass or they are skipped"
    exit 1
fi

echo "Checking for system.properties file..."
if [ -f system.properties ];
  then
    echo "system.properties file found"
  else
    echo "java.runtime.version=11" > system.properties
    [[ $? -eq 0 ]] && echo "system.properties created"
fi

echo "Connecting to Server..."
echo "You may be prompted to verify if you would like to continue connecting to the server."
echo "If prompted to continue type 'yes'."

ssh root@$IPADDRESS bash << setup_dokku

echo "Installing dokku mysql plugin..."
dokku plugin:install https://github.com/dokku/dokku-mysql.git mysql

echo "Installing dokku letsencrypt plugin..."
dokku plugin:install https://github.com/dokku/dokku-letsencrypt.git

echo "Creating dokku app..."
dokku apps:create $APP_NAME

echo "Creating mysql service on dokku container..."
dokku mysql:create $DB_NAME

echo "Linking dokku app and mysql service..."
dokku mysql:link $DB_NAME $APP_NAME

echo "Adding app environment variables..."
dokku config:set --no-restart "$APP_NAME" DOKKU_LETSENCRYPT_EMAIL=$EMAIL SPRING_JPA_HIBERNATE_DDL_AUTO=update SPRING_JPA_SHOW_SQL=true

echo "Adding domain to dokku app..."
dokku domains:add $APP_NAME $DOMAIN

echo "Removing default domain from app..."
dokku domains:remove $APP_NAME $APP_NAME

echo "Enabling HTTPS for your app..."
dokku letsencrypt:enable $APP_NAME

echo "Setting cron job to renew HTTPS..."
dokku letsencrypt:auto-renew $APP_NAME

echo "EXITING server..."
setup_dokku

echo "Adding dokku remote..."
#MYSQL_ROOT_PASSWORD=$(ssh root@${IPADDRESS} cat /var/lib/dokku/services/mysql/$DB_NAME/ROOTPASSWORD)
git remote add dokku dokku@$IPADDRESS:$APP_NAME
[[ $? -eq 0 ]] && echo "Dokku git remote created. Committing the system.properties file and running git push dokku master."
git add system.properties
git commit -m "feat: Added system.properties for deployment"
git push dokku master