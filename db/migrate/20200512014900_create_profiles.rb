class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|
      t.references :user, null: false, foreign_key: true
      t.string :first_name
      t.string :last_name
      t.float :geo_lat
      t.float :geo_long
      t.string :address

      t.timestamps
    end
  end
end
