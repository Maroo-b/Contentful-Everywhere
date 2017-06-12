class Category < ApplicationRecord
  has_and_belongs_to_many :products

  def self.create_from_entry(cat_entry, product)
    cat_fields = cat_entry.fields.select do |k,v|
      Category.column_names.include?(k.to_s)
    end.merge({
      icon: cat_entry.fields[:icon].url,
      contentful_id: cat_entry.id
    })
    category = Category.find_or_create_by(cat_fields)
    category.products << product
  end

end
