class CreateScraperinfos < ActiveRecord::Migration
  def change
    create_table :scraperinfos do |t|
      t.text :message

      t.timestamps null: false
    end
  end
end
