class CreateGeneralAccount < ActiveRecord::Migration[5.2]
  def change
    create_table :general_accounts do |t|
      t.integer :fee, null: false
      t.timestamps
    end
    add_reference :general_accounts, :back, foreign_key: true
  end
end
