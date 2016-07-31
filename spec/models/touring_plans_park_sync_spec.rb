require 'rails_helper'
require 'spec_helper'

RSpec.describe TouringPlansParkSync, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  subject { TouringPlansParkSync.new }
  describe '#title' do
    it 'works' do
      expect(subject.title).to eq("touring plans park sync")
    end
  end

  describe '#update_a' do
    
  end

  describe '#update_park_venues(park_route_key)' do
    it 'works' do
      #make multiple touringplans_venues
      build_list(:remote_touring_plans_park_eatery_detail)
      #make a specific touring plans venue
      remote_tp_venue = create(:remote_touring_plans_park_eatery_detail, name: "The Fountain", permalink: "the-fountain")
      park_route_key  = :epcot
      venue           = remote_tp_venue
      expect(subject.update_park_venues(park_route_key)).to eq("something")
    end
  end
  #
  #   # it 'works' do
  #   #   #make multiple hotels
  #   #   create_list(:hotel, 25)
  #   #   #make multiple foursquare_reviews
  #   #   create_list(:foursquare_review, 25)
  #   #   #make a specific hotel
  #   #   hotel               = create(:hotel, foursquare_venue_id: "", name: "Disney's Contemporary Resort")
  #   #   #make a specific foursquare_review
  #   #   foursquare_review   = create(:foursquare_review, venue_id: "4b761bb6f964a520333d2ee3", name: "Disney's Contemporary Resort")
  #   #   #run the method to copy the foursquare_review.venue_id to hotel.foursquare_venue_id
  #   #   #the hotel.foursquare_venue_id should == foursquare_review.venue_id
  #   #   expect(HotelSync.new.attach_foursquare_review_to_hotel(hotel.name)).to eq("something") #update works!
  #   #
  #   # end
  #
  #   it 'updates hotel.foursquare_venue_id to be the same as its foursquare_review' do
  #     # #make multiple hotels
  #   #   create_list(:hotel, 25)
  #   #   #make multiple foursquare_reviews
  #   #   create_list(:foursquare_review, 25)
  #   #   #make a specific hotel
  #   #   hotel               = create(:hotel, foursquare_venue_id: "", name: "Disney's Contemporary Resort")
  #   #   #make a specific foursquare_review
  #   #   foursquare_review   = create(:foursquare_review, venue_id: "4b761bb6f964a520333d2ee3", name: "Disney's Contemporary Resort")
  #   #   #run the method to copy the foursquare_review.venue_id to hotel.foursquare_venue_id
  #   #   #the hotel.foursquare_venue_id should == foursquare_review.venue_id
  #   #   expect(HotelSync.new.attach_foursquare_review_to_hotel(hotel.name).foursquare_venue_id).to eq(foursquare_review.venue_id) #update works!
  #   #
  #   end
  # end
  #
  
end
