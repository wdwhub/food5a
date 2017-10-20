class FixFousquareColumn < ActiveRecord::Migration[5.1]
  def change
    rename_column :cached_photos, :fousquare_user, :foursquare_user_name
  end
end
