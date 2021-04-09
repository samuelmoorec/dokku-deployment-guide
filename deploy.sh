#!/bin/bash
# example
# ./deploy.sh example.com example email@example.com
DOMAIN=$1
APP_NAME=$2
EMAIL=$3
DB_NAME=$2-mysql
IPADDRESS=$4

# Verifies that app name is a valid name and wont cause failures later.
if [[ ! ($APP_NAME =~ ^[a-z_]+$) ]] || [[ ! ($APP_NAME =~ ^[a-z].*)  ]]; then
    echo "App name must start with a lowercase letter and can only consist of lowercase letters and underscores."
    echo "Please review your app name and run the command again."
    echo "Exiting..."
    exit 1
fi

# Verifies that the email is a valid email.
if [[ ! ($EMAIL =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$) ]]
then
    echo "Please check your email to make sure that it is a valid email."
    echo "Exiting..."
    exit 1
fi

# Verifies that the ip address is a valid ip address.
if [[ ! ($IP =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$) ]]; then
  echo "IP address is invalid, Please check your ip address and try again"
  echo "Exiting..."
  exit 1
fi

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

echo "Adding swap partition...
fallocate -l 3G /swapfile
dd if=/dev/zero of=/swapfile bs=1024 count=1048576
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
echo "/swapfile swap swap defaults 0 0" >> /etc/fstab
echo "Successfully added 3G swap partition."


echo "Checking for dokku mysql plugin..."
if [ ! -d "/var/lib/dokku/plugins/enabled/mysql" ];
  then
    echo "mysql plugin not found."
    echo "Installing dokku mysql plugin..."
    dokku plugin:install https://github.com/dokku/dokku-mysql.git mysql
  else
    echo "mysql plugin found."
fi

echo "Checking for dokku letsencrypt plugin..."
if [ ! -d "/var/lib/dokku/plugins/enabled/letsencrypt" ];
  then
    echo "letsencrypt plugin not found."
    echo "Installing dokku letsencrypt plugin..."
    dokku plugin:install https://github.com/dokku/dokku-letsencrypt.git
  else
    echo "letsencrypt plugin found."
fi

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