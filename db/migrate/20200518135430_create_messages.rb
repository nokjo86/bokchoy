class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.references :sender
      t.references :recipient
      t.references :listing, null: false, foreign_key: true
      t.text :body
      t.boolean :closed, default: false
      t.references :thread

      t.timestamps
    end
  end
end
