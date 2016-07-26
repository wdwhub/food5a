require 'rails_helper'

RSpec.describe DfbReviewParser, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  # to stub nokogiri
  # parsable_document = Nokogiri::XML(open(Rails.root + 'spec/support/shared_examples/cheshire-cafe.html'))
  # fragment          = parsable_document.css('div.entry-content')
  
  describe '#title' do
    it 'works' do
      expect(DfbReviewParser.new(parsable_document:"phone").title).to eq("dfb review parser")
    end
  end
  
  describe '#parse_details' do
    it 'returns a hash' do
      expect(DfbReviewParser.new(parsable_document: []).parse_details).to be_a(Hash)
    end
  end
  
  describe '#collect_description of cheshire-cafe' do
    # strips ending puctuation and turns into symbol to match the key in the keys array
    # "Disney Dining Plan: ".gsub(/\W/, ' ').strip.gsub!(/( )/, '_').downcase!.to_sym
    it 'contains the word "Service"' do
      expect(DfbReviewParser.new(parsable_document: []).collect_description).to eq("Counter Service")
    end
  end

  describe '#collect_service of cheshire-cafe' do
    it 'contains the word "Service"' do
      pulled_document      = Nokogiri::HTML(open(Rails.root + 'spec/support/shared_examples/cheshire-cafe.html'))
      parsable_document    = pulled_document.css('div.entry-content')
      expect(DfbReviewParser.new(parsable_document: parsable_document).collect_description).to eq("Counter Service")
    end
  end

end
collect_service