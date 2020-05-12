class Profile < ApplicationRecord
  belongs_to :user
  has_many :listings
  attr_accessor :location
  validates :first_name, presence: true, length: { minimum: 2 }
  validates :last_name, presence: true, length: { minimum: 2 }

end
