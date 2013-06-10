namespace :paperclip do
  desc "Install paperclip dependencies"
  task :install, roles: :web do
    run "#{sudo} apt-get -y update"
    run "#{sudo} apt-get -y install imagemagick --fix-missing"
  end
  after "deploy:install", "paperclip:install"
end