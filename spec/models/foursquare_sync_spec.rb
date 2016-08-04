require 'rails_helper'

RSpec.describe FoursquareSync, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  subject { FoursquareSync.new }
  describe '#title' do
    it 'works' do
      expect(subject.title).to eq("foursquare sync")
    end
  end
  
  describe '#collect_all_wdw_venue_names' do
    
    before do
      create_list(:venue, 25)
    end
    
    # it 'works' do
    #   expect(subject.list_all_wdw_venue_names).to eq("something")
    # end
    it 'is an Array' do
      expect(subject.collect_all_wdw_venue_names).to be_an(Array)
    end
    
    it 'has a String for its first element' do
      expect(subject.collect_all_wdw_venue_names.first).to be_a(String)
    end
    
    it 'has between 10 and 20 elements' do
      expect(subject.collect_all_wdw_venue_names.length).to be_within(10).of(20)
    end
  end

  describe '#create_or_update_foursquare_eatery(venue_name: venue_name)' do
    let(:venue_name) { "Aloha Isle Refreshments" }
    let(:fsq_aloha_isle) { File.read( Rails.root + 'spec/support/shared_examples/foursquare_aloha_isle.json' ) }
    let(:fsq_aloha_isle_search) { File.read( Rails.root + 'spec/support/shared_examples/foursquare_aloha_isle_search.json' ) }
    
    before do
      # search for name
      stub_request(:get, "https://api.foursquare.com/v2/venues/search?client_id=R1TDM0FYS2YSOFTWG2QU2DS0OE00BZLMQCQPMKUGO5CJGNYH&client_secret=1N5G1D22C2410VE3RJXPS10Y31E2WA0BT45KYJFTGR0S35QN&ll=28.37777,-81.56498&query=Aloha%20Isle%20Refreshments&v=20160609").
        with(:headers => {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby gem'}).
        to_return(:status => 200, :body => fsq_aloha_isle_search, :headers => {})
      
        # return venue with venue_Id 
        stub_request(:get, "https://api.foursquare.com/v2/venues/4b7054c3f964a52041132de3?client_id=R1TDM0FYS2YSOFTWG2QU2DS0OE00BZLMQCQPMKUGO5CJGNYH&client_secret=1N5G1D22C2410VE3RJXPS10Y31E2WA0BT45KYJFTGR0S35QN&v=20160609").
          with(:headers => {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby gem'}).
          to_return(:status => 200, :body => fsq_aloha_isle, :headers => {})

    end

    it 'works' do
      expect(subject.create_or_update_foursquare_eatery(venue_name: venue_name)).to eq("something")
    end
  end
end
