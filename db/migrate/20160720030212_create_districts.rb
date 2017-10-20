class CreateDistricts < ActiveRecord::Migration[5.1]
  def change
    create_table :districts do |t|
      t.string :name
      t.string :permalink
      t.boolean :is_park
      t.string :credit
      t.string :photo_url
      t.string :flickr_search_term
      t.datetime :published_at
      t.string :wdw_uri

      t.timestamps
    end
  end
end
