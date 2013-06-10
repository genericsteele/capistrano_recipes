desc "Enter the rails console in production"
task :console, roles: :app do
  run_remote "cd #{current_path} ; RAILS_ENV=production bundle exec rails console"
end
  
desc "Enter the production shell"
task :bash, roles: :app do
  run_remote "cd #{current_path} ; bash"
end
  
def run_remote(cmd)
  server = find_servers_for_task(current_task).first
  exec "ssh #{user}@#{server} -t '#{cmd}'"
end