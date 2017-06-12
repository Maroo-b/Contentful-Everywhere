class Brand < ApplicationRecord
  has_many :products, dependent: :destroy
  has_many :phones, dependent: :destroy

  def self.create_from_entry(brand_entry)
    brand_fields = brand_entry.fields.select do |k,v|
      Brand.column_names.include?(k.to_s)
    end.merge({
      logo: brand_entry.fields[:logo].url
    })
    brand = Brand.find_or_create_by(contentful_id: brand_entry.id)
    brand.update_attributes(brand_fields)
    create_brand_phones(brand_entry.fields[:phone], brand)
    brand
  end

  def self.create_brand_phones(phone_fields, brand)
    brand.phones.destroy_all
    if phone_fields
      phone_fields.each do |phone|
        brand.phones << Phone.create(number: phone)
      end
    end
  end
end
