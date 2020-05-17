class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :listing
  validates :quantity, numericality: true, inclusion: { in: 1..100 }
end
