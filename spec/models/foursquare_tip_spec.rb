require 'rails_helper'

RSpec.describe FoursquareTip, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  subject { FoursquareTip.new }
  describe '#title' do
    it 'works' do
      expect(subject.title).to eq("i am foursquare_tip")
    end
  end
  
  describe '#venue_tips(venue_id)' do
    let(:aloha_isle_tips) { File.read( Rails.root + 'spec/support/shared_examples/foursquare_aloha_isle_tips.json' ) }

    before do
    stub_request(:get, "https://api.foursquare.com/v2/venues/4b7054c3f964a52041132de3/tips?client_id=R1TDM0FYS2YSOFTWG2QU2DS0OE00BZLMQCQPMKUGO5CJGNYH&client_secret=1N5G1D22C2410VE3RJXPS10Y31E2WA0BT45KYJFTGR0S35QN&v=20160609").
      with(:headers => {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby gem'}).
      to_return(:status => 200, :body => aloha_isle_tips, :headers => {})

    end
    it 'works' do
      venue_id = '4b7054c3f964a52041132de3'
      expect(subject.venue_tips("4b7054c3f964a52041132de3")).to eq("somthing")
      # expect(alohao_isle_tips).to eq("someting")
    end
    it 'has more than one tip' do
      expect(subject.venue_tips("4b7054c3f964a52041132de3").tips.length).to be > 1
    end

    it 'has a first tip' do
      expect(subject.venue_tips("4b7054c3f964a52041132de3").tips.first).to eq("something")
    end

    it 'has an ID for the first tip' do
      expect(subject.venue_tips("4b7054c3f964a52041132de3").tips.first.id).to be_a(String)
    end

    it 'has text for the first tip' do
      expect(subject.venue_tips("4b7054c3f964a52041132de3").tips.first.text).to be_a(String)
    end

    it 'has an user ID for the first tip' do
      expect(subject.venue_tips("4b7054c3f964a52041132de3").tips.first.user.first.id).to be_a(String)
    end

    it 'has an user photo_prefix for the first tip' do
      expect(subject.venue_tips("4b7054c3f964a52041132de3").tips.first.user.first.photo_prefix).to be_a(String)
    end

    it 'has an user photo_suffix for the first tip' do
      expect(subject.venue_tips("4b7054c3f964a52041132de3").tips.first.user.first.photo_suffix).to be_a(String)
    end

    it 'has an user first_name for the first tip' do
      expect(subject.venue_tips("4b7054c3f964a52041132de3").tips.first.user.first.first_name).to be_a(String)
    end

    it 'has an user last_name for the first tip' do
      expect(subject.venue_tips("4b7054c3f964a52041132de3").tips.first.user.first.last_name).to be_a(String)
    end

  end
  
end
