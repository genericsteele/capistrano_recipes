desc "Backup the Postgresql Database"
namespace :pg do
  task :backup => [:environment] do
  # Requires a database.yml file, an 'S3_BUCKET' envrionment variable, and the AWS gem configured 
   dbconfig = YAML.load(File.read(Rails.root.join("config/database.yml")))[Rails.env]
   stamp = Time.now.strftime "%Y-%m-%d_%H-%M-%S"
   path = Rails.root.join "db/backups/"
   file_name = "#{dbconfig['database']}_#{stamp}_dump.sql.gz"
   dbconfig = YAML.load(File.read(Rails.root.join("config/database.yml")))[Rails.env]
   sh "pg_dump -h localhost -U #{dbconfig['username']} #{dbconfig['database']} | gzip -c > #{path + file_name}"
   
   s3 = AWS::S3.new
   bucket = s3.buckets[ENV['S3_BUCKET']]
   object = bucket.objects["backups/#{file_name}"].write(file: path + file_name)
   
  end
  
  task :setup_folders => :environment do
    sh "mkdir -p #{Rails.root.join "db/backups"}"
  end
end


