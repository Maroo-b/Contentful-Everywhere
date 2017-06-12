class Product < ApplicationRecord
  has_and_belongs_to_many :tags, dependent: :destroy
  has_and_belongs_to_many :categories, dependent: :destroy
  has_many :images, dependent: :destroy
  belongs_to :brand

  class << self
    def content_type
      '2PqfXUJwE8qSYKuM0U6w8M'
    end

    def create_from_entry(product_entry, brand)
      product_fields = product_entry.fields.select do |k,v|
        Product.column_names.include?(k.to_s)
      end
      product = Product.find_or_create_by(contentful_id: product_entry.id)
      product.brand = brand
      product.update_attributes(product_fields)
      product
    end

  end

end
