class CreateJoinTableProductTag < ActiveRecord::Migration[5.1]
  def change
    create_join_table :products, :tags do |t|
      # t.index [:product_id, :tag_id]
      # t.index [:tag_id, :product_id]
    end
  end
end
