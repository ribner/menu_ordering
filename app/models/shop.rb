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

  def parse_for_google_maps
    @google_map_params = [street_address, city, state].join(" ")
    @google_map_params.gsub!(" ", "+")
  end
end
