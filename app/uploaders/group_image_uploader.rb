# encoding: utf-8

class GroupImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick
  storage :fog
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  process :resize_to_fit => [300, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  version :thumb do
    process :resize_to_fit => [50, 50]
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
     %w(jpg jpeg gif png)
  end
end
