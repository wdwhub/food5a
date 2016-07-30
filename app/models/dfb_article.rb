class DfbArticle < ApplicationRecord
  belongs_to :dfb_eatery
  belongs_to :venue
end
