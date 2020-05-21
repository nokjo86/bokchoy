class Order < ApplicationRecord
  belongs_to :profile
  has_many :order_items, dependent: :destroy
  has_many :listings, through: :order_items

  enum delivery: { "Local Pickup": 1, "Delivery": 2 }
end
