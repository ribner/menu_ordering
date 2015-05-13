class Item < ActiveRecord::Base
  require 'csv'

  belongs_to :shop
  has_many :orders, through: :orderjoins

  mount_uploader :photo, PhotoUploader

  validates :name, presence: true
  validates :price, presence: true


  def self.import(file,shop_id)
    CSV.foreach(file.path, headers: true) do |row|
      item_hash = row.to_hash # exclude the price field
      item_hash["shop_id"] = shop_id
      item = @shop.items.where(id: item_hash["id"])
      Item.create!(item_hash)
    end
  end
end
