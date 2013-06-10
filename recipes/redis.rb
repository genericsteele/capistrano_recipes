set_default(:redis_pid, "/var/run/redis/redis-server.pid")
namespace :redis do
  desc "Install the latest release of redis-server"
  task :install, roles: :app do
    add_apt_repository "ppa:chris-lea/redis-server"
    run "#{sudo} apt-get -y update"
    run "#{sudo} apt-get -y install redis-server"
  end
  after "deploy:install", "redis:install"
  
  desc "Setup the redis-server config file"
  task :setup, roles: :app do
    template "redis.erb", "/tmp/redis_conf"
    run "#{sudo} mv /tmp/redis_conf /etc/redis/redis.conf"
    restart
  end
  after "deploy:setup", "redis:setup"
  
  %w[start stop restart].each do |command|
    desc "#{command} redis-sever"
    task command, roles: :app do
      run "#{sudo} service redis-server #{command}"
    end
  end
end
