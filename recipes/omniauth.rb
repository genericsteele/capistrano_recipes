namespace :omniauth do
  desc "Setup omni lib dependencies"
  task :setup, roles: :app do
    run "#{sudo} apt-get update"
    run "#{sudo} apt-get install -y libxslt-dev libxml2-dev"
  end
  after "deploy:install", "omniauth:install"
end