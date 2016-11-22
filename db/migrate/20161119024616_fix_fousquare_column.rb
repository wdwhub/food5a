class FixFousquareColumn < ActiveRecord::Migration[5.0]
  def change
    rename_column :cached_photos, :fousquare_user, :foursquare_user_name
    rename_column :photos, :fousquare_user, :foursquare_user_name
  end
end
