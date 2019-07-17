class ChangeExpirationDateToCreditCards < ActiveRecord::Migration[5.2]
  def change
    change_column :credit_cards, :expiration_date, :string
  end
end
