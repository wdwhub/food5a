require 'rails_helper'

RSpec.describe VenueSync, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  subject { VenueSync.new }
  describe '#title' do
    it 'works' do
      expect(subject.title).to eq("venue sync")
    end
  end
  
  describe '#update_from_touringplans_com(permalink)' do
    # it 'works' do
    #     #make multiple venues
    #     create_list(:venue, 25)
    #     #make multiple touring_plans_eateries
    #     create_list(:touring_plans_eatery, 25)
    #     #make a specific venue
    #     venue               = create(:venue, permalink: "aloha-isle")
    #     #make a specific touring_plans_eatery
    #     touring_plans_eatery   = create(:touring_plans_eatery, permalink: venue.permalink)
    #     #run the method to copy the foursquare_review.venue_id to hotel.foursquare_venue_id
    #     #the hotel.foursquare_venue_id should == foursquare_review.venue_id
    #     expect(subject.update_from_touringplans_com(venue.permalink)).to eq("something") #update works!
    #
    # end
    
    it 'returns a class of Venue' do
      #make multiple venues
      create_list(:venue, 25)
      #make multiple touring_plans_eateries
      create_list(:touring_plans_eatery, 25)
      #make a specific venue
      venue               = create(:venue, permalink: "aloha-isle")
      #make a specific touring_plans_eatery
      touring_plans_eatery   = create(:touring_plans_eatery, permalink: venue.permalink)
      expect(subject.update_from_touringplans_com(venue.permalink)).to be_a(Venue)
    end
  end
  
  describe '#update_from_disneyfoodblog_com(permalink)' do
    
    it 'works' do
      
    end
  end
end
