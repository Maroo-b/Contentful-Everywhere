require 'rails_helper'

RSpec.describe "Products requests" do
  describe "index endpoint" do
    it 'send a list of products' do
      get '/api/products'

      expect(response).to be_success
    end
  end

  describe "synchronize endpoint" do
    it 'start synchronization job' do
      allow(SynchronizationJob).to receive(:perform_later)
      get '/api/products/synchronize?initial=true'

      json = JSON.parse(response.body)
      expect(SynchronizationJob).to have_received(:perform_later)
      expect(json['msg']).to eq('Initial synchronization starts soon.')
      expect(response).to be_success

    end
  end
end
