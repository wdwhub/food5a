require 'rails_helper'

RSpec.describe CachedPhoto, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  
  describe '#title' do
    it 'works' do
      expect(subject.title).to eq("i am cached_photo")
    end
  end
  
end
