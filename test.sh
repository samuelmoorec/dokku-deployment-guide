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

ask() {
    local prompt default reply
    if [[ ${2:-} = 'Y' ]]; then
        prompt='Y/n'
        default='Y'
    elif [[ ${2:-} = 'N' ]]; then
        prompt='y/N'
        default='N'
    else
        prompt='y/n'
        default=''
    fi
    while true; do
        # Ask the question (not using "read -p" as it uses stderr not stdout)
        echo -n "$1 [$prompt] "
        # Read the answer (use /dev/tty in case stdin is redirected from somewhere else)
        read -r reply </dev/tty
        # Default?
        if [[ -z $reply ]]; then
            reply=$default
        fi
        # Check if the reply is valid
        case "$reply" in
            Y*|y*) return 0 ;;
            N*|n*) return 1 ;;
        esac
    done
}
MAILTRAPUSERNAME=username;


if ask "Are you using the mail_trap service for emailing?";
then
    echo $MAILTRAPUSERNAME

    else
      echo not moving forward
fi
#curl -o /dev/null -s -w "%{http_code}" http://$IP
