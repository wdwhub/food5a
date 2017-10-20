class AddFoursquarePhotoIdToCachedPhoto < ActiveRecord::Migration[5.1]
  def change
    add_column :cached_photos, :foursquare_photo_id, :string
  end
end
