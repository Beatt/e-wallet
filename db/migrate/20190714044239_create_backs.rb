class CreateBacks < ActiveRecord::Migration[5.2]
  def change
    create_table :backs do |t|
      t.integer :value_in_cents, limit: 8, default: 0
      t.datetime :approved_at
      t.datetime :invalid_at
      t.string :error_message
      t.string :error_code
      t.string :type
      t.string :recipient_account, null: true
      t.references :customers, foreign_key: true
      t.timestamps null: false
    end
  end
end
