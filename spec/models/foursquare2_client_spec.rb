require 'rails_helper'

RSpec.describe Foursquare2Client, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  
  describe '#title' do
    it 'works' do
      expect(subject.title).to eq("i am foursquare2")
    end
  end
  
  describe '#client' do
    let(:fsq_disney_springs_query) { File.read( Rails.root + 'spec/support/shared_examples/fsq_venue_disney_springs.json' ) }
    let(:venue_id) { "4ecc3303f5b90c1c343087c6" }
    before do    
      stub_request(:get, "https://api.foursquare.com/v2/venues/4ecc3303f5b90c1c343087c6?client_id=R1TDM0FYS2YSOFTWG2QU2DS0OE00BZLMQCQPMKUGO5CJGNYH&client_secret=1N5G1D22C2410VE3RJXPS10Y31E2WA0BT45KYJFTGR0S35QN&v=20160609").
        with(:headers => {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby gem'}).
        to_return(:status => 200, :body => fsq_disney_springs_query, :headers => {})

    end
    
    # it 'works' do
    #   expect(subject.client.venue(venue_id)).to eq("something")
    # end
    
    it 'has an id that has a length between 10 and 40 characters' do
      expect(subject.client.venue(venue_id)[:id].length).to be_within(20).of(20)
    end
    
    it 'has a name that has a length more than 2 characters' do
      expect(subject.client.venue(venue_id)[:name].length).to be >= 2
    end
    
    it 'has a url that has a length more than 7 characters' do
      expect(subject.client.venue(venue_id)[:url].length).to be >= 7
    end
    
  end
end
