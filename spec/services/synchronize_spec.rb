require 'rails_helper'

RSpec.describe Synchronize do
  describe '.call' do
    it 'create product data from synchronization data' do
      VCR.use_cassette('initial_sync') do
        Synchronize.call

        expect(Product.count).to eq(4)
        expect(Brand.count).to eq(3)
        expect(Category.count).to eq(2)
        expect(SyncTrace.count).to eq(1)
      end
    end
  end
end
