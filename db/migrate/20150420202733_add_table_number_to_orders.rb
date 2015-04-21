class AddTableNumberToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :table, :integer, null: false
  end
end
