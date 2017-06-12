class Product < ApplicationRecord
  has_and_belongs_to_many :tags, dependent: :destroy
  has_and_belongs_to_many :categories, dependent: :destroy
  has_many :images, dependent: :destroy
  belongs_to :brand

  def self.content_type
    '2PqfXUJwE8qSYKuM0U6w8M'
  end

end
