#!/bin/bash
DOMAIN=$1
GITHUB_USERNAME=$2

echo "Retrieving ${GITHUB_USERNAME}'s public keys from github..."

PUBLIC_KEYS=$(curl -s https://github.com/$GITHUB_USERNAME.keys)

if [ "$PUBLIC_KEYS" != "Not Found" ]; then
  echo "Successfully retrieved ${GITHUB_USERNAME}'s public keys"
else
  echo "Could not retrieve ${GITHUB_USERNAME}'s public keys"
  echo "Please make sure the username is spelt correctly."
  exit 1
fi

ssh root@$DOMAIN bash << addsshkey
echo "Adding ${GITHUB_USERNAME}'s public keys to ${DOMAIN}'s authorized_keys..."
echo "$PUBLIC_KEYS" >> ~/.ssh/authorized_keys
[[ $? -eq 0 ]] && echo "Successfully added ${GITHUB_USERNAME}'s public keys to ${DOMAIN}'s authorized_keys."
addsshkey