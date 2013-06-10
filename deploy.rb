require "bundler/capistrano"

set :whenever_command, "bundle exec whenever"
require "whenever/capistrano"

load "config/recipes/monit"
load "config/recipes/base"
load "config/recipes/nginx"
load "config/recipes/unicorn"
load "config/recipes/postgresql"
load "config/recipes/figaro"
load "config/recipes/redis"
load "config/recipes/resque"
load "config/recipes/nodejs"
load "config/recipes/rbenv"
load "config/recipes/console"
load "config/recipes/check"
load "config/recipes/log"
load "config/recipes/paperclip"
load "config/recipes/aws"

server "(the server's ip address)", :web, :app, :db, primary: true

set :user, "deployer"
set :application, "(application name)"
set :deploy_to, "/home/#{user}/apps/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false

set :scm, "git"
set :repository, "git@github.com:genericsteele/#{application}.git"
set :branch, "master"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

after "deploy", "deploy:cleanup"
require './config/boot'
# require 'honeybadger/capistrano'
