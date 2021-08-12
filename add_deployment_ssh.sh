#!/bin/bash
DOMAIN=$1
USERNAME=$2

cat ~/.ssh/id_rsa.pub | ssh root@$DOMAIN dokku ssh-keys:add $USERNAME