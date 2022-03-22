## Ft_server

### Description :sparkles:
ft_server is a 42 project, I created a Dockerfile.
Running the dockerfile creates a container with several services. The container is running under Debian Buster
- a NGINX Web Server
- a Wordpress
- a PhpMyAdmin
- a MySQL database
The sever must use the SSL protocol when It's possible.
The Wordpress is using the MySQL data base, and is available from the PhpMyAdmin pannel.

The ports `80` and `443` are used, respectively for the web access and the SSL.

### Main purpose :page_facing_up:
The objective of this project was to discover the docker technology, and what a container is.
Then to learn how to organize the container to run the 3 services at the same time, set up its own web server, and link wordpress, mysql and phpmyadmin together.

### How to use :rocket:

First build the container by running:
```
docker build -t nameOfYourContainer .
```
Then run the container in interactive mode (`-it`) :
```
docker run -it -p 80:80 -p 443:443 nameOfYourContainer
```

#### Possibles issues:
_(if you don't have docker permissions, try)_
```
sudo chmod 777 /var/run/docker.sock
```
_(if a port of your machine is already in use, try)_
```
docker run -it -p 8042:80 -p 444:443 nameOfYourContainer
```
you can change the left port of the combination in this example `8042`.
