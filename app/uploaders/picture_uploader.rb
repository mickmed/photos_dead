class PictureUploader < CarrierWave::Uploader::Base
  storage :file
  permissions 0700
  include CarrierWave::MiniMagick
  process resize_to_limit: [4000, 4000]
 
  
  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  
  def store_dir
   prefix = ENV['OPENSHIFT_DATA_DIR'] ? "#{ENV['OPENSHIFT_DATA_DIR']}/" : ""
  "#{prefix}uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def url
   return "/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}/#{File.basename(file.path)}" if ENV['OPENSHIFT_DATA_DIR'] && file
   super
  end

# Addd a white list of extensions which are allowed to be uploaded.dddd
 def extension_white_list
  %w(jpg jpeg gif png)
 end
 
 

 
end


