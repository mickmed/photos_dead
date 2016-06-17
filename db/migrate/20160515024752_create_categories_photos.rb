class CreateCategoriesPhotos < ActiveRecord::Migration
  def change
    create_table :categories_photos do |t|
      t.integer :photo_id
      t.integer :category_id

      t.timestamps null: false
    end
  end
end
