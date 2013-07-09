# My Capistrano Recipes

These are my collection of [Capistrano recipes](https://github.com/capistrano/capistrano) that set up a new Ubuntu 12.10 server with a variety of services, including: 

* Nginx
* Postgres
* Redis
* Unicorn
* Rbenv
* Ruby 1.9.3-p429
* Rails 3.2.13
* Resque
* Node
* AWS dependencies
* Omniauth
* Paperclip (Imagemagick)
* Monit
* Figaro-style app configuration

## Setup
There are a few things you'll need to do if you want to use these scripts. 

### Add the Deployer user and ssh keys

First you'll need to be able to ssh into whatever server you are setting up and create a new `deployer` user:

```bash
adduser deployer --ingroup sudo
# put in your sudo password and skip all the account info
exit
```

It's super helpful to add your [ssh key](https://help.github.com/articles/generating-ssh-keys) to the server so you don't need to put in your password everytime you deploy:

```bash
#on your machine
cat ~/.ssh/id_rsa.pub | ssh deployer@{YOUR SERVER IP OR DOMAIN NAME} 'cat >> ~/.ssh/authorized_keys'
```

### Customize the scripts to your app

* Pick and choose the recipes you want to load in [deploy.rb](https://github.com/genericsteele/capistrano_recipes/blob/master/deploy.rb#L6-L21)
* Add your [server's ip address](https://github.com/genericsteele/capistrano_recipes/blob/master/deploy.rb#L23) to [deploy.rb](https://github.com/genericsteele/capistrano_recipes/blob/master/deploy.rb)
* Add your [application's name](https://github.com/genericsteele/capistrano_recipes/blob/master/deploy.rb#L26) to deploy.rb
* Add your [github account](https://github.com/genericsteele/capistrano_recipes/blob/master/deploy.rb#L32) and make sure the repo is correct in deploy.rb
* Add your server domain name to [nginx.rb](https://github.com/genericsteele/capistrano_recipes/blob/master/recipes/nginx.rb#L2)
