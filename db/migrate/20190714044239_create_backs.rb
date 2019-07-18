class CreateBacks < ActiveRecord::Migration[5.2]
  def change
    create_table :backs do |t|
      t.integer :value_in_cents, limit: 8, default: 0
      t.datetime :approved_at
      t.datetime :invalid_at
      t.string :error_message
      t.string :error_code
      t.string :type, null: false
      t.integer :account_recipient, null: true
      t.timestamps null: false
    end
    add_reference :backs, :customer, foreign_key: true
    add_reference :backs, :credit_card, foreign_key: true, null: true
    add_foreign_key :backs, :customers, column: :account_recipient
  end
end
