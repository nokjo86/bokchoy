class Listing < ApplicationRecord
  belongs_to :profile, optional: true
  has_one_attached :picture

  enum delivery: { "Local Pickup": 1, "Delivery": 2, "Both": 3 }
end
