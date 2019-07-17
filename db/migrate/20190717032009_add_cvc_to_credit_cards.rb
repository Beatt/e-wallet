class AddCvcToCreditCards < ActiveRecord::Migration[5.2]
  def change
    add_column :credit_cards, :cvc, :string, null: false
  end
end
