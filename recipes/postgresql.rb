set_default(:postgresql_host, "localhost")
set_default(:postgresql_user) { application }
set_default(:postgresql_password) { Capistrano::CLI.password_prompt "PostgreSQL Password: " }
set_default(:postgresql_database) { "#{application}_production" }
set_default(:postgresql_pid) { "/var/run/postgresql/8.4-main.pid" }

namespace :postgresql do
  desc "Install the latest stable release of PostgreSQL."
  task :install, roles: :db, only: { primary: true } do
    add_apt_repository "ppa:pitti/postgresql"
    run "#{sudo} apt-get -y update"
    run "#{sudo} apt-get -y install postgresql libpq-dev"
  end
  after "deploy:install", "postgresql:install"
  
  desc "Create a database for this application"
  task :create_database, roles: :db, only: {primary: true} do
    run %Q{#{sudo} -u postgres psql -c "create user #{postgresql_user} with password '#{postgresql_password}';"}
    run %Q{#{sudo} -u postgres psql -c "create database #{postgresql_database} owner #{postgresql_user};"}
    run %Q{echo "localhost:*:#{postgresql_database}:#{postgresql_user}:#{postgresql_password}" > /home/#{user}/.pgpass}
    run %Q{#{sudo} chmod 0600 /home/#{user}/.pgpass}
  end
  after "deploy:setup", "postgresql:create_database"
  
  desc "Generate the database.yml config file"
  task :setup, roles: :app do
    run "mkdir -p #{shared_path}/config"
    template "postgresql.yml.erb", "#{shared_path}/config/database.yml"
  end
  after "deploy:setup", "postgresql:setup"
  
  desc "Symlink the database.yml file into the latest release"
  task :symlink, roles: :app do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
  after "deploy:finalize_update", "postgresql:symlink"
end
