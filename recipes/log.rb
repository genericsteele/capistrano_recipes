desc 'tails the production log'
task :log, roles: :app do
  run "tail -f #{shared_path}/log/production.log"
end