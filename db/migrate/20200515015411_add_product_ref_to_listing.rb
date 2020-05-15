class AddProductRefToListing < ActiveRecord::Migration[6.0]
  def change
    add_reference :listings, :product, null: false, foreign_key: true
  end
end
