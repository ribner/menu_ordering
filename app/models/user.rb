class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :shops
  has_many :orders

  def define_admin
    self.admin = true
    self.save
  end

  def find_shop
    @shop = Shop.where(user_id: self.id)[0]
  end

  def this_user
    if current_user
      return current_user
    end
  end

end


