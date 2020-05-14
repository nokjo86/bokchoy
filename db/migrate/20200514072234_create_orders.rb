class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.references :profile, null: false, foreign_key: true
      t.integer :delivery
      t.float :total_amount_paid
      t.float :freight_charge

      t.timestamps
    end
  end
end
