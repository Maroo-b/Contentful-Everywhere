class Brand < ApplicationRecord
  has_many :products, dependent: :destroy
  has_many :phones, dependent: :destroy
end
