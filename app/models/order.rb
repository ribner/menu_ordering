class Order < ActiveRecord::Base
  belongs_to :user
  has_many :items, through: :orderjoins
  has_many :orderjoins

end
