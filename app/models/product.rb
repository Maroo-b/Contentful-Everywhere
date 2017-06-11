class Product < ApplicationRecord
  has_and_belongs_to_many :tags
  has_and_belongs_to_many :categories
  has_many :images
  belongs_to :brand

end
