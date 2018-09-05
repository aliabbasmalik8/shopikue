class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :title
      t.text :description
      t.decimal :price
      t.decimal :purchasing_price
      t.decimal :discount
      t.string :catagory
      t.integer :rating

      t.timestamps
    end
  end
end
