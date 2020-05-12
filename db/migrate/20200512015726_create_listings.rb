class CreateListings < ActiveRecord::Migration[6.0]
  def change
    create_table :listings do |t|
      t.references :user_profile, null: false, foreign_key: true
      t.string :title
      t.text :description
      t.integer :delivery
      t.boolean :closed, default: false

      t.timestamps
    end
  end
end
