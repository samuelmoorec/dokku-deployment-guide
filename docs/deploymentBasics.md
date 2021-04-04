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