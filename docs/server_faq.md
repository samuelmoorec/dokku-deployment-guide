# Server access and logs

This document contains code for connecting to your server, grabbing live or past error logs, and how to share access to other team members. 

## How to connect to server
If we are trying to connect to our server to run dokku commands or any other commands, we need to **remote** into our server. 

To remote into our server is actually quite easy all we have to do is run one of the following commands switching out the **IP address** or **domain** with our own IP address or domain.
### IP address method
```
ssh root@<server_ip_address>
```
Here is an example of the use below.

```
#Example

ssh root@135.23.1.14
```
### Domain method
```
ssh root@<domain>
```
Here is an example of the use below.

 

```
#Example

ssh root@example.com
```

## How to view application's logs
If we would like to view our application's logs, we can do this by first remoting into the server and then running the dokku logs command. 

To run the dokku logs command we need to have our application name.
```
dokku logs <app_name>
```
Here is an example of the use below.

```
#Example

dokku logs spring_blog
```

If we want to see the logs in real time we can also add a `-t` flag to the command.

```
#Example

dokku logs spring_blog -t
```
## How to give server access
If we want to give server access to someone, we need to run the following command replacing the example GitHub username with the GitHub username of the person we intend to add.
```
bash <(curl -sS https://raw.githubusercontent.com/gocodeup/dokku-deployment-guide/main/addssh.sh) <ip_address> <github_username>
```
Here is an example of the use below.

```
#Example

bash <(curl -sS https://raw.githubusercontent.com/gocodeup/dokku-deployment-guide/main/addssh.sh) 123.12.3.241 codeytheduck
```

## How to give server push access
If we want other team members to be able to push our main branch up to the server, we just need to run the following command.

Replace the example name with your first name and the ip address with your servers ip address or your site's domain name.
```
bash <(curl -sS https://raw.githubusercontent.com/gocodeup/dokku-deployment-guide/main/add_deployment_ssh.sh) <ip_address> <name>
```
Here is an example of the use below.

```
#Example

bash <(curl -sS https://raw.githubusercontent.com/gocodeup/dokku-deployment-guide/main/add_deployment_ssh.sh) 123.12.3.241 synthia
```