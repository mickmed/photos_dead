class PictureUploader < CarrierWave::Uploader::Base
  storage :file
  permissions 0700
  include CarrierWave::MiniMagick
  process resize_to_limit: [800, 800]

 

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
   

  "$OPENSHIFT_DATA_DIR/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"


  end







  # Add a white list of extensions which are allowed to be uploaded.dddd
  def extension_white_list
    %w(jpg jpeg gif png)
  end
end


