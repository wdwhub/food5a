class CreateCachedTips < ActiveRecord::Migration[5.1]
  def change
    create_table :cached_tips do |t|
      t.string :foursquare_tip_id
      t.text :text
      t.string :kind
      t.string :canonical_url
      t.string :lang
      t.string :likes_count
      t.string :log_view
      t.string :agree_count
      t.integer :foursquare_user_id
      t.string :foursquare_user_first_name
      t.string :foursquare_last_name
      t.string :foursquare_user_gender
      t.string :foursquare_user_photo_prefix
      t.string :foursquare_user_photo_prefix
      t.string :foursquare_user_photo_suffix

      t.timestamps
    end
  end
end
