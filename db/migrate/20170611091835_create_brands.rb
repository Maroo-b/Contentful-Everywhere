class CreateBrands < ActiveRecord::Migration[5.1]
  def change
    create_table :brands do |t|
      t.string :company_name
      t.string :logo
      t.text :description
      t.string :website
      t.string :twitter
      t.string :email
      t.string :contentful_id, index: true

      t.timestamps
    end
  end
end
