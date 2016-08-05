class CachedPhoto < ApplicationRecord
  belongs_to :foursquare_eatery
  def title
    "i am cached_photo"
  end
  
  
end
