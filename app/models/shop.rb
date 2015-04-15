class Shop < ActiveRecord::Base
  belongs_to :user
  has_many :items
  mount_uploader :photo, PhotoUploader

  validates :name, presence: true
  validates :street_address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip_code, presence: true



  def editable_by?(current_user)
      current_user.admin || current_user == user
  end
end
