class Photo < ActiveRecord::Base

 is_impressionable
 require 'image_size'
 #has_many :categories_photos
 has_many :impressions, foreign_key: "impressionable_id"
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
