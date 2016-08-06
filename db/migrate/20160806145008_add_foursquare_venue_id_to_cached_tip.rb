class AddFoursquareVenueIdToCachedTip < ActiveRecord::Migration[5.0]
  def change
    add_column :cached_tips, :foursquare_venue_id, :string
  end
end
