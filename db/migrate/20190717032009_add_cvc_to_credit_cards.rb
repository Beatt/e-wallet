class AddCvcToCreditCards < ActiveRecord::Migration[5.2]
  def change
    add_column :credit_cards, :cvc, :string, limit: 4, null: false
  end
end
