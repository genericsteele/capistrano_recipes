set_default(:resque_pid) { "#{current_path}/tmp/pids/resque_worker.pid" }
set_default(:resque_user, "deployer")
set_default(:resque_user_group, "admin")

namespace :resque do
  desc "Setup Resque initializer"
  task :setup, roles: :app do
    run "mkdir -p #{shared_path}/config"
    template "resque.erb", "/tmp/resque_init"
    run "chmod +x /tmp/resque_init"
    run "#{sudo} mv /tmp/resque_init /etc/init.d/resque"
  end
  after "deploy:setup", "resque:setup"
  
  %w[start stop restart].each do |command|
    desc "#{command} resque workers"
    task command, roles: :app do
      run "service resque #{command}"
    end
    after "deploy:#{command}", "resque:#{command}"
  end
end