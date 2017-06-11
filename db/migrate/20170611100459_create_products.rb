class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :product_name
      t.string :slug
      t.text :product_description
      t.string :sizetypecolor
      t.decimal :price
      t.integer :quantity
      t.string :sku
      t.string :website
      t.string :contentful_id, index: true

      t.timestamps
    end
  end
end
