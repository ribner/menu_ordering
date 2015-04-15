class CreateShops < ActiveRecord::Migration
  def change
    create_table :shops do |t|
      t.references :user, index: true, foreign_key: true
      t.string :name, null: false
      t.string :street_address, null: false
      t.string :city, null: false
      t.string :state, null: false, default: "Massachusetts"
      t.string :zip_code, null: false
      t.text :description
      t.string :phone
      t.boolean :reservations, default: false
      t.boolean :delivery, default: false
      t.timestamps null: false
    end
  end
end
