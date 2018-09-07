class ChangeDefaultValueOfQuantiyInOrderProducts < ActiveRecord::Migration[5.2]
  def change
    change_column :order_products, :quantity, :integer ,default: 1
    change_column :order_products, :discount, :integer ,default: 0
  end
end
