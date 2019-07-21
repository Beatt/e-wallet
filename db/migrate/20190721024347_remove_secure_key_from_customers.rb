class RemoveSecureKeyFromCustomers < ActiveRecord::Migration[5.2]
  def change
    remove_column :customers, :secure_key, :string
  end
end
