require 'rails_helper'

RSpec.describe Product, type: :model do
  describe '.create_from_entry' do
    it 'create a new product from entry' do
      brand = Brand.create
      product_entry_fields = {
        product_name: "test",
        slug: "test-test",
        product_description: "test description",
        price: 11, 
        quantity: 1,
        sku: "abc",
        image: [],
        tags: [],
      }

      product_entry = double(fields: product_entry_fields, id: "123")

      expect{ Product.create_from_entry(product_entry, brand) }.to change{
        Product.count
      }.by(1)
    end
  end
end
