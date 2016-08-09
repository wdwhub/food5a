class FoursquareEatery < ApplicationRecord
  belongs_to :venue
  
  def find_cached_images
    cached_photos = CachedPhoto.where("foursquare_venue_id = ?", foursquare_id)
  end
  
  def find_cached_tips
    cached_tips = CachedTip.where("foursquare_venue_id = ?", foursquare_id)
  end
  
  def title
    "cow says"
  end
end
# 