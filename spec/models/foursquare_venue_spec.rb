require 'rails_helper'

RSpec.describe FoursquareVenue, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  describe '#title' do
    it 'works' do
      expect(subject.title).to eq("i am foursquare_venue")
    end
  end
  describe '#venue(venue_id)' do
    let(:venue_id) { "4ecc3303f5b90c1c343087c6" }
    let(:fsq_disney_springs_query) { File.read( Rails.root + 'spec/support/shared_examples/fsq_venue_disney_springs.json' ) }
    
    
    before do
      stub_request(:get, "https://api.foursquare.com/v2/venues/4ecc3303f5b90c1c343087c6?client_id=R1TDM0FYS2YSOFTWG2QU2DS0OE00BZLMQCQPMKUGO5CJGNYH&client_secret=1N5G1D22C2410VE3RJXPS10Y31E2WA0BT45KYJFTGR0S35QN&v=20160609").
        with(:headers => {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby gem'}).
        to_return(:status => 200, :body => fsq_disney_springs_query, :headers => {})
      
    end
    
    it 'works' do
      expect(subject.venue(venue_id)).to eq("something")
    end
    
    it 'has an id that has a length between 10 and 40 characters' do
      expect(subject.venue(venue_id)[:id].length).to be_within(15).of(20)
    end
    
    it 'has a name that has a length more than 2 characters' do
      expect(subject.venue(venue_id)[:name].length).to be >= 2
    end
    
    it 'has a url that has a length more than 7 characters' do
      expect(subject.venue(venue_id)[:url].length).to be >= 7
    end
    
  end

  describe '#search(query: query)' do
    let(:query) { "disney springs" }
    let(:search_results) {  File.read( Rails.root + 'spec/support/shared_examples/fourscore_venues_search_query_disney.json' ) }
    before do
      stub_request(:get, "https://api.foursquare.com/v2/venues/search?client_id=R1TDM0FYS2YSOFTWG2QU2DS0OE00BZLMQCQPMKUGO5CJGNYH&client_secret=1N5G1D22C2410VE3RJXPS10Y31E2WA0BT45KYJFTGR0S35QN&ll=28.37777,-81.56498&query=disney%20springs&v=20160609").
        with(:headers => {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby gem'}).
        to_return(:status => 200, :body => search_results, :headers => {})
    
    end
      
    # it 'works' do
    #   expect(subject.search(query: query)).to eq("something")
    # end
    
    it 'is a Hash' do
      expect(subject.search(query: query)).to be_a(Hash)
    end

    it 'has an Array for its first Value' do
      expect(subject.search(query: query)[:venues]).to be_an(Array)
      
    end
    
    it 'has more than 3 items for its first value' do
      expect(subject.search(query: query)[:venues].length).to  be >= 3
    end
    # it 'contains OpenStructs' do
    #   expect(FoursquareVenue.new(connection: search_venues_connection).search_venues("disney")[0]).to be_a(OpenStruct)
    #   expect(FoursquareVenue.new(connection: search_venues_connection).search_venues("disney").last).to be_a(OpenStruct)
    # end
    #
    # it 'has an OpenStruct as the first element of the Array with an id that has a length between 20 and 30 characters' do
    #   expect(FoursquareVenue.new(connection: search_venues_connection).search_venues("disney").first.id.length).to be_within(20).of(30)
    # end
    #
    # it 'has an OpenStruct as the first element of the Array with a name that has a length more than 3 characters' do
    #   expect(FoursquareVenue.new(connection: search_venues_connection).search_venues("disney").first.name.length).to be >= 2
    # end
    #
    # it 'has an OpenStruct as the first element of the Array with a url that has a length more than 7 characters' do
    #   expect(FoursquareVenue.new(connection: search_venues_connection).search_venues("disney").first.url.length).to be >= 7
    # end
  end

  describe '#photos' do
    let(:venue_id) { "4ecc3303f5b90c1c343087c6" }
    let(:fsq_disney_springs_query) { File.read( Rails.root + 'spec/support/shared_examples/fsq_venue_disney_springs.json' ) }
    
    
    before do
      stub_request(:get, "https://api.foursquare.com/v2/venues/4ecc3303f5b90c1c343087c6?client_id=R1TDM0FYS2YSOFTWG2QU2DS0OE00BZLMQCQPMKUGO5CJGNYH&client_secret=1N5G1D22C2410VE3RJXPS10Y31E2WA0BT45KYJFTGR0S35QN&v=20160609").
        with(:headers => {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby gem'}).
        to_return(:status => 200, :body => fsq_disney_springs_query, :headers => {})
      
    end
    # it 'works' do
    #   expect(subject.photos(venue_id: venue_id, query: "")).to eq("someting")
    # end
    
    it 'is a Representation' do
      expect(subject.photos(venue_id: venue_id, query: "")).to be_a(Representation)
    end
    
    it 'has a collection of photos' do
      expect(subject.photos(venue_id: venue_id, query: "").photos.length).to be_within(5).of(6) 
    end
    
    it 'has a an id for the first photo as a string' do
      expect(subject.photos(venue_id: venue_id, query: "").photos.first.id).to be_a(String)
    end
    
    it 'has a an prefix for the first photo as a string' do
      expect(subject.photos(venue_id: venue_id, query: "").photos.first.prefix).to be_a(String)
    end
    
    it 'has a an suffix for the first photo as a string' do
      expect(subject.photos(venue_id: venue_id, query: "").photos.first.suffix).to be_a(String)
    end
    
    it 'has a an height for the first photo as a Integer' do
      expect(subject.photos(venue_id: venue_id, query: "").photos.first.height).to be_a(Integer)
    end
    
    it 'has a an width for the first photo as a Integer' do
      expect(subject.photos(venue_id: venue_id, query: "").photos.first.width).to be_a(Integer)
    end

    it 'has a an user for the first photo as a User' do
      expect(subject.photos(venue_id: venue_id, query: "").photos.first.user.first).to be_a(User)
    end
  end
end
