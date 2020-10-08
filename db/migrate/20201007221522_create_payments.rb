class CreatePayments < ActiveRecord::Migration[6.0]
  def change
    create_table :payments do |t|
      t.references :sender, references: :users, index: true
      t.references :receiver, references: :users, index: true

      t.string :description

      t.float :amount, null: false

      t.timestamps
    end

    add_index :payments, %i[sender_id receiver_id]
  end
end
