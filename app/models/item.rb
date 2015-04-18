class Item < ActiveRecord::Base
  belongs_to :shop
  has_many :orders, through: :orderjoins
  mount_uploader :photo, PhotoUploader

  validates :name, presence: true
  validates :price, presence: true

end
