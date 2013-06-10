namespace :aws do
  desc "Install libraries AWS depends upon"
  task :install, roles: :app do
    run "#{sudo} apt-get update"
    run "#{sudo} apt-get install libxslt-dev libxml2-dev"
  end
end
