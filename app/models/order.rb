class Order < ActiveRecord::Base
  belongs_to :user
  has_many :items, through: :orderjoins
  has_many :orderjoins
  belongs_to :shop

   def total_price
    self.items.sum(:price)
  end

end
