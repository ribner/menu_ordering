class CreateOrderjoins < ActiveRecord::Migration
  def change
    create_table :orderjoins do |t|
      t.references :order, index: true, foreign_key: true
      t.references :item, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end