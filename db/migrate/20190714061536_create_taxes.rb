class CreateTaxes < ActiveRecord::Migration[5.2]
  def change
    create_table :taxes do |t|
      t.string :name, null: false
      t.integer :limit_value, null: false
      t.integer :minimum_value, null: false
      t.integer :percentage, null: false
      t.integer :fixed_rate, null: false
      t.timestamps
    end
    add_reference :backs, :tax, foreign_key: true, null: true
  end
end
