class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :user, index: true, foreign_key: true
      t.string :order_status, default: "submitted", null: false
      t.integer :total
      t.boolean :paid, default: false, null: false
      t.timestamps null: false
    end
  end
end
