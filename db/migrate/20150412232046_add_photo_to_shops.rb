class AddPhotoToShops < ActiveRecord::Migration
  def change
    add_column :shops, :photo, :string
  end
end
