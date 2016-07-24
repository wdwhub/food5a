require 'rails_helper'

RSpec.describe DfbConnection, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  describe 'DfbConnection' do
    subject { DfbConnection.new }
    describe '#title' do
      it 'works' do
        expect(subject.title).to eq("i am dfb_connection")
      end
    end
  end
end
