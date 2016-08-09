class ChangeFoursquareVenueIdInCachedPhoto < ActiveRecord::Migration[5.0]
  def change
      change_column :cached_photos, :foursquare_venue_id, :string
  end
end
