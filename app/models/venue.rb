class Venue < ApplicationRecord
	# members.where(id: Response.select(:member_id))
	# Venue.where(id: FoursquareEatery.select(:venue_id)).count
  scope :has_foursquare_eatery, -> { where(id: FoursquareEatery.select(:venue_id)) }
  
  has_many  :dfb_articles
  has_many  :dfb_eateries, through: :dfb_articles  
  has_one   :foursquare_eatery
  has_many  :cached_photos
end
