class CreateGeneralAccount < ActiveRecord::Migration[5.2]
  def change
    create_table :general_accounts, &:timestamps
    add_reference :general_accounts, :back, foreign_key: true
    add_reference :general_accounts, :taxe, foreign_key: true
  end
end
