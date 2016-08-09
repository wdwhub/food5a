class CachedTip < ApplicationRecord
  def find_parent_foursquare_venue(venue_id: self.foursquare_venue_id)
    cached_foursquare_eatery = FoursquareEatery.where("foursquare_id = ?", venue_id).first
  end
  
end
