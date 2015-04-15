# encoding: utf-8

class PhotoUploader < CarrierWave::Uploader::Base
 include CarrierWave::MiniMagick

  process resize_to_fit: [800, 800]
  version :thumb do
    process resize_to_fill: [200, 200]
  end
  version :top_pick, from_version: :thumb do
    process resize_to_fit: [168, 165]
  end
  version :small_thumb, from_version: :thumb do
    process resize_to_fill: [20, 20]
  end

  if Rails.env.production? || Rails.env.development?
    storage :fog
  else
    storage :file
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

end

