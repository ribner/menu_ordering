class AddShoppictureToShops < ActiveRecord::Migration
  def change
    add_column :shops, :shoppicture, :string
  end
end
