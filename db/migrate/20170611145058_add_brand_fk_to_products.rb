class AddBrandFkToProducts < ActiveRecord::Migration[5.1]
  def change
    add_reference :products, :brand, foreign_key: true
  end
end
