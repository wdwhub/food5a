class Venue < ApplicationRecord
  has_many  :dfb_articles
  has_many  :dfb_eateries, through: :dfb_articles  
  has_one   :foursquare_eatery
  has_many  :cached_photos
end
