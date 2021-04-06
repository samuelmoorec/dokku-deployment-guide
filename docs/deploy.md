# Big Deploy Guide
This is your go to guide if you want to deploy you app from start to finish all in one sitting.

## NameCheap Domain setup
For this guide we will be using [NameCheap](https://www.namecheap.com/) to setup our domain. The domain we will be using for example purposes will be `exampledomain.com` through out this documentation we will be using this domain to help you understand how to use your own domain.

1. Login / register on [namecheap.com](https://www.namecheap.com/)
2. Purchase domain ***Note: this can be a $1 domain, it does not have to be expensive***
3. Navigate to your [Domain List](https://ap.www.namecheap.com/domains/list/) on namecheap
4. Select the **MANAGE** button on the domain you wish to use for this project
5. Under **NAMESERVERS** switch ***NameCheap BasicDNS*** to ***Custom DNS***
6. Enter the following server names

```
        ns1.digitalocean.com
        ns2.digitalocean.com
        ns3.digitalocean.com
```
7. Click green checkmark to save changes
## Digital Ocean Server Setup
1. Login / register on [digitalocean.com](https://cloud.digitalocean.com/)

3. Click the green **Create** Button -> [Droplets](https://cloud.digitalocean.com/droplets/new)
4. Under ***Choose an image*** select the tab **Marketplace**.
5. In the search bar search for ***"Dokku"*** .
6. Select the option with the smiling teal whale. After it is selected it should show **Dokku** *X.XX.X* **on Ubuntu**.
7. Under Choose a plan make sure that Basic is Selected.
8. For **CPU options** select ***Regular Intel with SSD***.
9. For the plan choose ***$5/mo*** plan *it should be the cheapest plan*.
   **additional note:** *we will be able to upgrade this later if we wish, Dokku will let us know the storage and memory utilization on our server*.
9. Under **Choose a datacenter region** choose either ***New York*** or ***San Francisco***.
10. Under **Authentication** we need to make sure ***SSH keys*** is selected .
11. Next we need to add our public ssh key, we can begin by clicking the New SSH Key button.
12. The following command will copy your public ssh key to your clipboard, run it in your terminal.
    ``
    pbcopy <  "$HOME/.ssh/id_rsa.pub"
    ``
13. Paste your public ssh key into the SSH Key content field.
14. For the name you can name it something in reference to which device it is. For instance if your name is Val you could call it ***Val's Mac Book Air***.
15. Add the ssh key by clicking **Add SSH Key** button.
- (Optional) If you are working with a team you can add your team mates ssh keys to your droplet so that they will also have access to the droplet once set up.
16. Select all SHH keys that should have access to the droplet.

18. For **Choose a hostname** use something that represents what your droplet will be hosting. If we were hosting our springBlog on it I would name it ***springBlogDroplet***.
19. Click Create Droplet and wait for your droplet to be set up.
## Digital Ocean Domain Setup
### Configuring an A Record for your domain

This process will cause all requests for your domain to go to your server.

1.Go to [digital ocean's networking page](https://cloud.digitalocean.com/networking)

2. Add your domain (without the `www` or `http`) under "Add a Domain"
3. Under "Create a New Record" choose the "A" record (this should be selected by
   default)
4. For the hostname, enter `@`
5. For "will direct to", choose your droplet
6. Set TTL to 60
7. Click the "Create Record" button
### Configure Subdomains
A simple way to have any and all subdomain requests go to the same place as your
server is to do the following
1. Create a new record for your domain
2. Choose "CNAME" for the record type
3. For "Hostname", enter `*`
4. For "Is an Alias Of", enter `@`
5. Set TTL to 60
6. Click the "Create Record" button
## Deploy your application

we have created a simple script to deploy your applications to your server using dokku. To deploy your application run the following command in your project's integrated terminal after **switching** out the **domain**, **appname**, and **email** with your own.
```
bash <(curl -sS https://raw.githubusercontent.com/gocodeup/dokku-deployment-guide/master/deploy.sh) <YourDomain.com> <AppName> <youremail@example.com> <server_ip_address>
```
