class Product < ApplicationRecord
  has_many :listings
  has_many :subcategories, class_name: "Product", foreign_key: "category_id"
  belongs_to :category, class_name: "Product", optional: true
end
