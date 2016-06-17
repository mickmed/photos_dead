class Category < ActiveRecord::Base
  has_many :categories_photos
  has_and_belongs_to_many :photos
end
