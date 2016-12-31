class AddPhotoViewsToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :photo_views, :integar
  end
end
