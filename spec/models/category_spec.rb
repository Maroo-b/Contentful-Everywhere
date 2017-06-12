require 'rails_helper'

RSpec.describe Category, type: :model do
  describe '.create_from_entry' do
    it 'create a category record' do
      icon = double(url: 'icon_url')
      brand = Brand.create
      product = Product.create(brand_id: brand.id)

      category_entry_fields = {
        title: "test title",
        category_description: "cat desc",
        icon: icon
      }

      category_entry = double(fields: category_entry_fields, id: "123")

      expect{Category.create_from_entry(category_entry, product)}.to change{ 
        Category.count
      }.by(1)
    end
  end
end
