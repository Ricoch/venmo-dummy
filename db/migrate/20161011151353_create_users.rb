class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :email

      t.string   :first_name, default: ''
      t.string   :last_name,  default: ''
      t.string   :username,   default: ''

      t.timestamps null: false
    end

    add_index :users, :email, unique: true
  end
end
