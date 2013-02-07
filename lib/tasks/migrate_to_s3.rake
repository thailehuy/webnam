# Migrate local Refinery images & resources to S3.
# THIS VERSION WORKS FOR REFINERY 2
require 'aws/s3'

# Define the bucket name & folder
bucket_name = "dev-space-mwg"
bucket_folder = 'webnam'

desc "Connects to Amazon S3"
task :connect_to_s3 => :environment do

  AWS::S3::Base.establish_connection!(
        :access_key_id     => 'AKIAIDXYC27EPC3QFPPA',
        :secret_access_key => 'd6PXKZXTpw0rQ/Q6gdlGg2oxgefoORM9cOoN+Slk',
        :server => 's3-ap-southeast-1.amazonaws.com')

  AWS::S3::DEFAULT_HOST.replace "s3-ap-southeast-1.amazonaws.com"

  bucket = AWS::S3::Bucket.find(bucket_name)

# Get a list of all object keys in a bucket.
  puts 'List of current objects'
  puts bucket.objects.collect(&:key)

end

desc "Migrates all the Images to Amazon S3"
task :migrate_images_to_s3 => [:environment, :connect_to_s3] do
#  Rake::Task['connect_to_s3'].invoke
    migrate_to_s3(Refinery::Image, :image, "images", bucket_name, bucket_folder)
end

desc "Migrates all the Resources to Amazon S3"
task :migrate_resources_to_s3 => [:environment, :connect_to_s3] do
    migrate_to_s3(Refinery::Resource, :file, "resources", bucket_name, bucket_folder)
end

desc "Migrates all Images & Resources to Amazon S3"
task :migrate_all_to_s3 => [:environment, :connect_to_s3, :migrate_images_to_s3, :migrate_resources_to_s3]


def migrate_to_s3(class_name, type, directory, bucket, folder)
  puts "Migrating #{class_name} (#{type}) to S3..."
  styles = []

  # Process each attachment
  class_name.all.each_with_index do |attachment, n|
    success = false
    path = attachment.send(type.to_s).path rescue nil
    file = attachment.send(type.to_s).file rescue nil
    if path && file
      path.gsub!(/#{Rails.root.to_s + '/public/system/refinery/' + directory}/, '')

      success = upload(folder + path, file, bucket)

      puts "Saved #{path} to S3 (#{n}/#{class_name.count})"
    end
  end
end


def upload(path, file, bucket, retries = 3)
  begin
    AWS::S3::S3Object.store(path, file, bucket, :access => :public_read)
    sleep 1
  rescue => e
    put "Upload failed: #{e.message}"
    if retries > 0
      puts "Retrying..."
      return upload(path, file, bucket, (retries - 1))
    else
      puts "FAILED: #{path}#{file} to #{bucket}"
      return false
    end
  end
  true
end

