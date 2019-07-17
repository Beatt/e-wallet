class CreateCreditCards < ActiveRecord::Migration[5.2]
  def change
    create_table :credit_cards do |t|
      t.string :number, null: false
      t.string :expiration_date, limit: 5
      t.string :brand, null: false
      t.string :kind, null: false
      t.string :country, default: 'MX'
      t.string :last4, limit: 4, null: false
      t.timestamps
    end
    add_reference :credit_cards, :customer, foreign_key: true
  end
end
