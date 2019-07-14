class CreateGeneralAccount < ActiveRecord::Migration[5.2]
  def change
    create_table :general_accounts do |t|
      t.references :backs, foreign_key: true
      t.references :taxes, foreign_key: true
      t.timestamps
    end
  end
end
