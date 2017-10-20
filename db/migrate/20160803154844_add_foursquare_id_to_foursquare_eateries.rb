class AddFoursquareIdToFoursquareEateries < ActiveRecord::Migration[5.1]
  def change
    add_column :foursquare_eateries, :foursquare_id, :string
  end
end
