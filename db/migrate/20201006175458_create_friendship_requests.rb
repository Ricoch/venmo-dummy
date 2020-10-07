class CreateFriendshipRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :friendship_requests do |t|
      t.references :requester, references: :users, index: true
      t.references :receiver, references: :users, index: true

      t.timestamps
    end
  end
end
