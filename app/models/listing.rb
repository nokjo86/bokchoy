class Listing < ApplicationRecord
  belongs_to :user_profile
  has_one_attached :image

  enum delivery: { local_pickup: 1, delivery: 2, both: 3 }
end
