# Dokku Database Management
This guide is to help you with the basic database management from creating to a database to deleting it. This guide will currently only be covering for Dokku's [MySql plugin](https://github.com/dokku/dokku-mysql).
### The Dokku MySQL plugin
We use a MySQL plugin with Dokku to work with our database. This is required when working with any external database in Dokku. 

Our set-up script should handle the initial plugin install, but the command to do so again or fresh is:
```
sudo dokku plugin:install https://github.com/dokku/dokku-mysql.git mysql
```

### 

The set-up script we use covers creating a database, linking that database, and getting that initial configuration squared away. The rest of this document will show you how to connect to that database, grab your ROOT password that was generated, and a link to find the rest of the plug-in's documentation for further commands.

### Connecting To MySQL Prompt
To do queries in our Dokku database we just need to run a command while logged in to our server:
```
mysql:connect <database_name>
```
Here is an example of how one would enter their database.
```
#Example

dokku mysql:connect spring_blog_db
```
##### Finding the ROOT password 
When you log-in to your mysql database using the command above you will only have read access and **will not** be able to create, edit, delete anything.
<br />
*This means we cannot create addition databases or manually insert data into our databases.*
<br />
To get around this we can log-in as our database's root user. To do, so you will first have to know the root password; to print your databases root password to the terminal just run the following command from the server.
```
cat /var/lib/dokku/services/mysql/<database_name>/ROOTPASSWORD
```
Here is an example of how we would run the command above with our spring blog database.
```
#Example

cat /var/lib/dokku/services/mysql/spring_blog_db/ROOTPASSWORD
```
#### Logging in as root user
Once we know what our root password is we can log into our database as root so that we can make changes to the database itself. To log-in as the root user first run the `mysql:connect` command. After you have entered the database, and you are prompted for a mysql query you can run the following command.
```
SYSTEM mysql -u root -p
```
After you run this command you will be prompted for a password this is where you will enter your root password. If all was done correctly you will now be able to make changes to your database. When you are finished making changes to your database you will have to exit twice, once to log out of the root user and once again to log out of the original database user. 
### Additional help
If there is something that is not covered in this guide I would recommend using the following command.
```
mysql:help
```
Here is an example below.
```
#Example

dokku mysql:help
```
If that does not help you can find the plugin's official documentation [here](https://github.com/dokku/dokku-mysql#readme)

### Home Menu
Click here to go to [menu](https://github.com/gocodeup/dokku-deployment-guide)
