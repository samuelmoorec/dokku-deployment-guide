# Did you say deploying?
Deploying and deployment - these terms may be new, but deployment is a common topic in our industry. While we don't have an entire module dedicated to deploying, it is important to know what deployment is. It is worth noting that if you work for a larger company this will be a whole job on its own - on the other hand, if you work at a start-up this may be something you handle as part of a developer role. Deployment is a large topic of discussion on its own, so we don't go too deep into it. This guide will help you understand the fundamentals of deploying and how a specific type of server works with your application.

## What is deploying?
Up until this point we have only run applications on our own machines on what we call 'localhost' (e.g., 'http://localhost:8080/ads/all'). Deploying is when we take the necessary steps to put our application on a server while setting up any additional services we need to run that application successfully.

## What is a server?
In simple terms a server is a computer just like mine or yours, but there are some things that differentiate from our computers and a server. You might have heard the term 'dedicated server' - that is just referring to the fact that our servers aim to have no down-time or unscheduled periods of being offline. This means from the moment we boot up the server, we theoretically won't have to turn off our server. Well, now you might be thinking  *"could I just set up a computer at home and use it as a server and just never turn it off?"*. The simple answer is 'yes, you can', but *should you do that?*? Let's look at some reasons why it is much more common to use 3rd party companies to handle this task for us.

## What makes a server special?
There are a few reasons we pay companies to host servers for our applications. The first reason is what we mentioned in the last section - servers are dedicated and have minimal downtime if any downtime at all. We also use hosted servers because they are built with the proper network capabilities to handle the massive amounts of users all requesting information from the same server at the same time. Servers have much better bandwidth than our home networks do. A server is also going to be set up with specific hardware like a [solid state drive](https://serverguy.com/servers/ssd-and-hdd-server/#2) that allow more maximum read and write speeds. The last reason is that servers are scalable. Scalable means that if we were to need more memory or CPU's to improve performance, we can just scale up our server to give more processing power.

## Domains
Well, how do users gain access to the server and our application? The way we can call on our server is through the public ipv4 address, but when we tell somebody to go to our site we don't just give them a huge IP address. Can you imagine? "Yeah, I just finished up my big Codeup capstone project - check it out at 192.168.0.0.1". It'd be like inviting everyone over to your weekend cookout by sending them the latitude and longitude instead of your home's street address!

That is where domains come in. These domains are holding our server's public IP address so that when we call on our domain it will just direct our requests to the server. 

## Dokku
Dokku is the open source service that we will be using to control our application's life cycle on our servers. Dokku was built to be an open source alternative to another service called Heroku. Dokku is built off of Docker which gives us many benefits, including but not limited to
- Ability to run anywhere
- Pushing changes to deployment via git
- Free SSL certificates
- Easy Database management
- Can host multiple apps
- Easily set up environment variables