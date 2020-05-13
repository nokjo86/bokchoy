class Profile < ApplicationRecord
  belongs_to :user
  has_many :listings
  validates :first_name, presence: true, length: { minimum: 2 }
  validates :last_name, presence: true, length: { minimum: 2 }
  validates :address_line1, presence: true, length: { minimum: 5 }
  validates :suburb, :state, :country, presence: true
  validates :postcode, presence: true, length: { is: 4 }

  geocoded_by :address
  after_validation :geocode

  def address
    [address_line1, address_line2, suburb, state, postcode, country].join(',')
  end

end
