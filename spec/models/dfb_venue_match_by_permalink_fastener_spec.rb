require 'rails_helper'

RSpec.describe DfbVenueMatchByPermalinkFastener, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  describe '#title' do
    it 'works' do
      expect(subject.title).to eq("i am the permalink fastener")
    end
  end
  
  describe '#fuse_with_venue(venue_id)' do
    # it 'works' do
    #   venue         = create(:venue, permalink: "the-wave-restaurant")
    #   dfb_eatery    = create(:dfb_eatery, permalink: "http://www.disneyfoodblog.com/the-wave/")
    #   dfb_articles   = create_list(:dfb_article, 3, dfb_eatery_id: dfb_eatery.id)
    #   venue_id      = venue.id
    #   expect(subject.fuse_with_venue(venue_id)).to eq("something")
    # end
    
    it 'returns a hash' do
      venue         = create(:venue, permalink: "the-wave-restaurant")
      dfb_eatery    = create(:dfb_eatery, permalink: "http://www.disneyfoodblog.com/the-wave/")
      dfb_articles   = create_list(:dfb_article, 3, dfb_eatery_id: dfb_eatery.id)
      venue_id      = venue.id
      expect(subject.fuse_with_venue(venue_id)).to be_a(Hash)
    end

    it 'matches dfb_eatery with the proper venue through venue_to_dfb_eatery_hash' do
      venue         = create(:venue, permalink: "the-wave-restaurant")
      dfb_eatery    = create(:dfb_eatery, permalink: "http://www.disneyfoodblog.com/the-wave/")
      dfb_articles   = create_list(:dfb_article, 3, dfb_eatery_id: dfb_eatery.id)
      venue_id      = venue.id
      expect(subject.fuse_with_venue(venue_id)[:venue_articles][0].venue).to eq(venue)
    end
  end
end
