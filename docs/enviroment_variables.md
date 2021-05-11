# Dokku environment variables
This guide is for setting environment variables specific to your application. This guide will be helpful for setting variables that our `application.properties` would normaly handle.
## What are environment variables?
Before we can get started on adding environment variables to our application we first need to know what they are. Ultimately environment variables are just variables that you set in your system. These can often be used to make your life easier or hold important system info. A good example of this is if we needed to change our current director to our home directory we could just use the command `cd $HOME` and we would be taken to our home directory. You can find more on environment variables [here](https://medium.com/chingu/an-introduction-to-environment-variables-and-how-to-use-them-f602f66d15fa#:~:text=An%20environment%20variable%20is%20a,at%20a%20point%20in%20time.)
## SpringBoot environment variables
Typically, in a spring boot project we will have a file in the resources' directory called `application.properties`. Spring boot makes our lives easier by letting our application use this file as our project's environment variables when the file is present, but when we deploy our application does not have a `application.properties` because it is in our git ignore file. This means that we will have to set the environment variables in the remote server. When we set these variables on our server there is a strict naming convention that we must follow which can be found [here](https://docs.spring.io/spring-boot/docs/current/reference/html/spring-boot-features.html#boot-features-external-config-relaxed-binding-from-environment-variables). Essentially all we have to do is Uppercase the entirety of the variable name. Replace all `.` with `_` and entirely delete any dash characters `-`. We can find an example of how this would look down below. The value of the variable will stay the same as it is in the `application.properties`.
```
application.properties
spring.jpa.hibernate.ddl-auto=update

--------- converts to ---------

enviroment variable
SPRING_JPA_HIBERNATE_DDLAUTO=update
```
