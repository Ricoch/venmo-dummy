class CreateFriendships < ActiveRecord::Migration[6.0]
  def change
    create_table :friendships do |t|
      t.references :user_a, references: :users, index: true
      t.references :user_b, references: :users, index: true

      t.timestamps
    end
  end
end
