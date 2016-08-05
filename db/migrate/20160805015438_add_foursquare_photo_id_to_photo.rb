class AddFoursquarePhotoIdToPhoto < ActiveRecord::Migration[5.0]
  def change
    add_column :photos, :foursquare_photo_id, :string
  end
end
