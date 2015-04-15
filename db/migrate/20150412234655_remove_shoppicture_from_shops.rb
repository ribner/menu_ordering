class RemoveShoppictureFromShops < ActiveRecord::Migration
  def change
    remove_column :shops, :shoppicture, :string
  end
end
