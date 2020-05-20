class Listing < ApplicationRecord
  belongs_to :profile, optional: true
  belongs_to :product
  has_one_attached :image
  has_many :messages
  has_many :cart_items
  has_many :carts, through: :cart_items
  validates :title, presence: true, length: { in: 3..40 }
  validates :description, presence: true, length: { in: 6..200 }
  validates :price, presence: true, numericality: true, inclusion: { in: 0.01..100 }

  enum delivery: { "Local Pickup": 1, "Delivery": 2, "Both": 3 }
end
