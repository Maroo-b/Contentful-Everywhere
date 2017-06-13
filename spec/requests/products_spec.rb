require 'rails_helper'

RSpec.describe "Products requests" do
  it 'send a list of products' do
    get '/api/products'

    expect(response).to be_success
  end
end
