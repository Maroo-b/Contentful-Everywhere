class CreateCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :categories do |t|
      t.string :title
      t.string :icon
      t.text :category_description
      t.string :contentful_id

      t.timestamps
    end
    add_index :categories, :contentful_id
  end
end
