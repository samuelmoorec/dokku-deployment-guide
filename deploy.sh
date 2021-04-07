#!/bin/bash
# example
# ./deploy.sh example.com example email@example.com
read -p $'Enter the domain name (without http or www): ' DOMAIN
read -p $'Name of the application (in lowercase): ' APP_NAME
read -p $'Email Address: ' EMAIL
read -p $'Enter the servers ip address: ' IP_ADDRESS
DB_NAME="${APP_NAME}_db"

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
if [[ ! ($IP_ADDRESS =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$) ]]; then
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

ssh root@$IP_ADDRESS bash << setup_dokku

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
dokku config:set --no-restart "$APP_NAME" DOKKU_LETSENCRYPT_EMAIL=$EMAIL SPRING_JPA_HIBERNATE_DDL_AUTO=update SPRING_JPA_SHOW_SQL=true spring_mail_host=smtp.mailtrap.io spring_mail_port=25 spring_mail_username=username spring_mail_password=password spring_mail_properties_mail_smtp_auth=true spring_mail_properties_mail_smtp_starttls_enable=true spring_mail_from=no-reply@$DOMAIN

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

echo "Adding production remote..."
#MYSQL_ROOT_PASSWORD=$(ssh root@${IP_ADDRESS} cat /var/lib/dokku/services/mysql/$DB_NAME/ROOTPASSWORD)
git remote add dokku dokku@$IP_ADDRESS:$APP_NAME
[[ $? -eq 0 ]] && echo "Production remote created. Committing the system.properties file and running git push production main/master."
git add system.properties
git commit -m "feat: adds system.properties file for deployment"
main_exists=$(git branch --list main)
if [[ ${main_exists} ]];
then
  git push dokku main:master
else
  git push dokku master
fi