class DfbEatery < ApplicationRecord
  has_many :dfb_articles
  has_many :venues
end
