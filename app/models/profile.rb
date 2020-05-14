class Profile < ApplicationRecord
  belongs_to :user
  has_one :cart, dependent: :destroy
  has_many :listings, dependent: :destroy
  validates :first_name, presence: true, length: { minimum: 2 }
  validates :last_name, presence: true, length: { minimum: 2 }
  validates :address_line1, presence: true, length: { minimum: 5 }
  validates :suburb, :state, presence: true
  validates :postcode, presence: true, length: { is: 4 }
  geocoded_by :address
  after_validation :geocode_or_reset_coordinates, if: :address_line1_changed?
  after_create :init_cart
  
  private
  
  def init_cart
    self.create_cart
  end

  def address
    [address_line1, address_line2, suburb, state, postcode,"Australia"].join(',')
  end

  def geocode_or_reset_coordinates
    if geocode.nil?
      self.latitude = nil
      self.longitude = nil
    end
  end

end
