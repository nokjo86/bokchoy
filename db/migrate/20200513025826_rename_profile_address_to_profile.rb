class RenameProfileAddressToProfile < ActiveRecord::Migration[6.0]
  def change
    rename_column :profiles, :address, :address_line1
    add_column :profiles, :address_line2, :string
    add_column :profiles, :suburb, :string
    add_column :profiles, :state, :string
    add_column :profiles, :postcode, :string

  end
end
