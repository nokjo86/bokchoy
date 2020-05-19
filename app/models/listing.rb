class Listing < ApplicationRecord
  belongs_to :profile, optional: true
  belongs_to :product
  has_one_attached :image
  has_many :messages
  has_many :cart_items
  has_many :carts, through: :cart_items


  enum delivery: { "Local Pickup": 1, "Delivery": 2, "Both": 3 }
end
