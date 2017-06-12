require 'rails_helper'

RSpec.describe Synchronize do
  describe '.call' do
    context 'with initial: true' do
      it 'delete existing data' do
        VCR.use_cassette('initial_sync') do
          allow(Brand).to receive(:destroy_all)
          allow(Tag).to receive(:destroy_all)
          allow(Category).to receive(:destroy_all)

          Synchronize.call(initial: true)
          
          expect(Brand).to have_received(:destroy_all)
          expect(Tag).to have_received(:destroy_all)
          expect(Category).to have_received(:destroy_all)
        end
      end
      it 'create product data from synchronization data' do
        VCR.use_cassette('initial_sync') do
          Synchronize.call(initial: true)

          expect(Product.count).to eq(4)
          expect(Brand.count).to eq(3)
          expect(Category.count).to eq(2)
          expect(SyncTrace.count).to eq(1)
        end
      end
    end

    context 'with initial: false' do
      it 'does not clear existing data' do
        VCR.use_cassette('continue_sync') do
          allow(Brand).to receive(:destroy_all)
          allow(Tag).to receive(:destroy_all)
          allow(Category).to receive(:destroy_all)
          SyncTrace.create(sync_url: "https://cdn.contentful.com/spaces/vd02lcrceozr/sync?sync_token=w7Ese3kdwpMbMhhgw7QAUsKiw6bCi09CwpFYwpwywqVYw6DDh8OawrTDpWvCgMOhw6jCuAhxWX_CocOPwowhcsOzeEJSbUnCuSJtw5vDocOjO2cTwobCnG5zwpDCqcOSwqvCgEnCh1HChilGwoDCv0Nmw4cUe8KuTDbCtcOdw6jDtGDCv1A4w5TCjsKQQ8KiwqkAGSUKw6rDpTfCncO8LsK0wogow6LDtQ")
          Synchronize.call

          expect(Brand).to_not have_received(:destroy_all)
          expect(Tag).to_not have_received(:destroy_all)
          expect(Category).to_not have_received(:destroy_all)
        end
      end

      it 'does use last SyncTrace url' do
        VCR.use_cassette('continue_sync') do
          allow(SyncTrace).to receive_message_chain(:last, :sync_url).and_return(
"https://cdn.contentful.com/spaces/vd02lcrceozr/sync?sync_token=w7Ese3kdwpMbMhhgw7QAUsKiw6bCi09CwpFYwpwywqVYw6DDh8OawrTDpWvCgMOhw6jCuAhxWX_CocOPwowhcsOzeEJSbUnCuSJtw5vDocOjO2cTwobCnG5zwpDCqcOSwqvCgEnCh1HChilGwoDCv0Nmw4cUe8KuTDbCtcOdw6jDtGDCv1A4w5TCjsKQQ8KiwqkAGSUKw6rDpTfCncO8LsK0wogow6LDtQ"
          )
          Synchronize.call

          expect(SyncTrace).to have_received(:last)
        end
      end
    end
  end
end
