require 'rails_helper'

RSpec.describe FoursquarePhoto, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  subject { FoursquarePhoto.new }
  describe '#title' do
    it 'works' do
      expect(subject.title).to eq("i am foursquare_photo")
    end
  end
  
  describe '#venue_photos(venue_id)' do
    let(:aloha_isle_photos) { File.read( Rails.root + 'spec/support/shared_examples/foursquare_aloha_isle_photos.json' ) }
    
    before do
      stub_request(:get, "https://api.foursquare.com/v2/venues/4b7054c3f964a52041132de3/photos?client_id=R1TDM0FYS2YSOFTWG2QU2DS0OE00BZLMQCQPMKUGO5CJGNYH&client_secret=1N5G1D22C2410VE3RJXPS10Y31E2WA0BT45KYJFTGR0S35QN&group=venue&v=20160609").
        with(:headers => {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby gem'}).
        to_return(:status => 200, :body => aloha_isle_photos, :headers => {})
      
    end
    it 'works' do
      venue_id = '4b7054c3f964a52041132de3'
      expect(subject.venue_photos("4b7054c3f964a52041132de3")).to eq("somthing")
      # expect(alohao_isle_photos).to eq("someting")
    end
  end
end
