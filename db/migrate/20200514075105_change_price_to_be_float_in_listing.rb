class ChangePriceToBeFloatInListing < ActiveRecord::Migration[6.0]
  def change
    change_column :listings, :price, :float
  end
end
