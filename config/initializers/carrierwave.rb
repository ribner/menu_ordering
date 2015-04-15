CarrierWave.configure do |config|
  if Rails.env.production? || Rails.env.development?
    config.permissions = 0666
    config.directory_permissions = 0777
    config.storage :fog

    config.fog_credentials = {
      provider:              "AWS",
      aws_access_key_id:     ENV["AWS_ACCESS_KEY_ID"],
      aws_secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"],
    }
    config.fog_directory  = ENV["S3_BUCKET"]
    config.fog_public     = false
    config.fog_attributes = { "Cache-Control" => "max-age=#{365.day.to_i}" }
  else
    config.storage :file
  end
end
