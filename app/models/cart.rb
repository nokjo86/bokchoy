class Cart < ApplicationRecord
  belongs_to :profile
  has_many :cart_items
  has_many :listings, through: :cart_items
end
