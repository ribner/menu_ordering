class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.references :shop, index: true, foreign_key: true
      t.string :name, null: false
      t.string :category
      t.string :description
      t.integer :price, null: false
      t.integer :cost, null: false
      t.string :photo
      t.timestamps null: false
    end
  end
end
