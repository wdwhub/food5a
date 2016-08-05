class FoursquareEatery < ApplicationRecord
  belongs_to :venue
  has_many :cached_photos
end
