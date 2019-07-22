class CreateCustomers < ActiveRecord::Migration[5.2]
  def change
    create_table :customers do |t|
      t.string :account_number, null: false
      t.string :name, null: false
      t.string :email, null: false
      t.string :access_token, null: false
      t.timestamps
    end
  end
end
