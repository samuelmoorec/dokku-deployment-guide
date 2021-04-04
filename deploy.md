# Did you say deploying?
Get ready to talk about Deploying. This term may be a new one for most of you but it is a common one in this industry. While we don't have an entire module dedicated to deploying it is important to now what it is. It is worth noting that if you work for a larger company this will be a whole job on its own while if you work at a start up this may be something you are more likely to see. Deployment can be a large topic of discussion on its own so we don't go to deep into it, as to make sure that we don't venture too far out of scope, but this guide will help you understand the fundamentals of deploying and how a server works with your application.

## What is deploying?
Up until this point we have only run applications on our own machines on what we call localhost. Deploying is when we take the necessary steps to put our application on a server while setting up any additional services we need to run that application.

## What is a server?
In simple terms a server is is just a computer just like mine or yours, but there are some things that differentiate from our computer and a server. You might have heard the term dedicated server and that is just referring to the fact that our servers don't have off time. This means from the moment we boot up the server we theoretically wont have to turn off our server. Well now you might be thinking  *"could I just set up a computer at home and use it as a server and just never turn it off?"*. The simple answer is yes you can, but the real question is *should you do that?*, and to that I say no you should not.

## What makes a server special?
There are a few reasons we pay companies to host servers for our applications. The first reason is because servers are dedicated and have minimal downtime if any downtime at all. We also use hosted servers because they are built with the proper network capabilities to handle the massive amounts of users all requesting information from the same server at the same time. To summarize the last reason in shorter and simpler terms Servers have much better bandwidth than our home networks. A server is also going to be set up with Solid State Drives that allow more maximum read and write speeds that not all computers would have. The last reason I am going to cover is that fact that servers are scalable meaning that if we were to need more memory or CPU's because we are noticing sluggish performance we can just scale up our application to give more processing power.

## Domains
A question you might be asking is how to users gain access to the server? The way we can call on our server is through the public ipv4 address, but when we tell somebody to go to our site we don't just give them a huge IP address. That is were domains come in. In simple terms the Domain is just holding our server's public IP address so that when we call on our domain it will just direct our requests to the server.

## Dokku
Dokku is the open source service that we will be using to control our application's life cycle on our servers. Dokku was built to be an open source alternative to another service called Heroku. Dokku is built off of Docker which gives us many benefits, including but not limited to
- Ability to run anywhere
- Pushing changes to deployment via git
- Free SSL certificates
- Easy Database management
- Can host multiple apps
- Easily set up environment variables

## NameCheap Domain setup
For this guide we will be using [NameCheap](https://www.namecheap.com/) to setup our domain. The domain we will be using for example purposes will be `exampledomain.com` through out this documentation we will be using this domain to help you understand how to use your own domain.

1. Login / register on [namecheap.com](https://www.namecheap.com/)
2. Purchase domain ***Note: this can be a $1 domain, it does not have to be expensive***
3. Navigate to your [Domain List](https://ap.www.namecheap.com/domains/list/) on namecheap
4. Select the **MANAGE** button on the domain you wish to use for this project
5. Under **NAMESERVERS** switch ***NameCheap BasicDNS*** to ***Custom DNS***
6. Enter in the following server names

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
6. Leave the default TTL
7. Click the "Create Record" button
### Configure Subdomains
A simple way to have any and all subdomain requests go to the same place as your
server is to do the following
1. Create a new record for your domain
2. Choose "CNAME" for the record type
3. For "Hostname", enter `*`
4. For "Is an Alias Of", enter `@`
5. Leave the default TTL
6. Click the "Create Record" button
## Deploy your application

we have created a simple script to deploy your applications to your server using dokku