#!/bin/bash
# example
# ./deploy.sh example.com example
#DOMAIN=$1
#ssh root@$DOMAIN bash << setup_dokku
#sudo echo hello
#dokku apps:list
#setup_dokku
#MYSQL_ROOT_PASSWORD=$(ssh root@${DOMAIN} cat /var/lib/dokku/services/mysql/$DB_NAME/ROOTPASSWORD)
#echo $MYSQL_ROOT_PASSWORD

#ARRAY=$1
#if [[ ! ($IP =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$) ]]; then
#  echo "IP address is invalid, Please check your ip address and try again"
#  echo "Exiting..."
#  exit 1
#fi

#for env_item in ${ARRAY[@]}; do
#  echo $env_item
#done
IP=$1
echo "We will now open your browser to a dokku setup page."
echo "click the blue button on the bottom that reads 'Finish Setup'."
echo "DO NOT CHANGE ANYTHING IN THE FIELDS!"
echo "After you click the button you will be redirected"
read -p "Press RETURN or ENTER to open the page."
#open http://$IP
if [[ $(curl -o /dev/null -s -w "%{http_code}" http://$IP) -eq 200 ]]; then
    echo "site is still up"
    else
      echo "site is no longer up"
fi
#curl -o /dev/null -s -w "%{http_code}" http://$IP
