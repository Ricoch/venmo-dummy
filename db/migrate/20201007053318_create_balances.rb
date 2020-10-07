class CreateBalances < ActiveRecord::Migration[6.0]
  def change
    create_table :balances do |t|
      t.references :external_payment_source, foreign_key: true
      t.decimal :change
      t.decimal :total

      t.timestamps
    end
  end
end
