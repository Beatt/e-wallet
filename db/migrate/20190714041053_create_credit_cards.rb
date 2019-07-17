class CreateCreditCards < ActiveRecord::Migration[5.2]
  def change
    create_table :credit_cards do |t|
      t.string :number
      t.string :expiration_date, limit: 5
      t.string :brand
      t.string :type
      t.string :country, default: 'MX'
      t.timestamps
    end
    add_reference :credit_cards, :customer, foreign_key: true
  end
end
