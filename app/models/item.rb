class Item < ActiveRecord::Base
  belongs_to :shop
  mount_uploader :photo, PhotoUploader

  validates :name, presence: true
  validates :price, presence: true
end
