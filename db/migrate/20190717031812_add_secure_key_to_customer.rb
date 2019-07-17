class AddSecureKeyToCustomer < ActiveRecord::Migration[5.2]
  def change
    add_column :customers, :secure_key, :string, null: false
  end
end
