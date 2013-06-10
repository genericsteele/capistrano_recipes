config = YAML::load_file(File.join(File.dirname(File.expand_path(__FILE__)), '..', 'application.yml'))
config.each { |c| set(c[0].downcase.to_sym, c[1]) }
namespace :figaro do
  desc "Move the application config file"
  task :setup, roles: :app do
    run "mkdir -p #{shared_path}/config"
    template "application.yml.erb", "#{shared_path}/config/application.yml"
  end
  after "deploy:setup", "figaro:setup"
  
  desc "Symlink the application.yml file into the latest release"
  task :symlink, roles: :app do
    run "ln -nfs #{shared_path}/config/application.yml #{release_path}/config/application.yml"
  end
  after "deploy:finalize_update", "figaro:symlink"
end