class DfbEatery < ApplicationRecord
  has_many :dfb_articles, dependent: :destroy
  has_many :venues, through: :dfb_articles
end
