class Venue < ApplicationRecord
  has_many :dfb_articles
  has_many :dfb_eatery, :through => :dfb_articles
end
