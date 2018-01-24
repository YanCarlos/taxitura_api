class DriverPhotoUploader < CarrierWave::Uploader::Base
  storage :file

  def store_dir
    "uploads/profile_photo/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end
  
end
