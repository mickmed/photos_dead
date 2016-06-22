class Photo < ActiveRecord::Base
 has_many :categories_photos
 has_and_belongs_to_many :categories
 mount_uploader :picture, PictureUploader
 validate  :picture_size

 private
 # Validates the size of an uploaded picture.
  def picture_size
   if picture.size > 15.megabytes
    errors.add(:picture, "should be less than 15MB")
   end
  end
 end
