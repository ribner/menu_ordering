class CreateYelpPhotoColumnInShops < ActiveRecord::Migration
  def change
    add_column :shops, :yelp_photo, :string
  end
end
