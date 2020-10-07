class AddFriendshipRequestFriendshipUsersIndex < ActiveRecord::Migration[6.0]
  def change
    add_index :friendships, [:user_a_id, :user_b_id], unique: true
    add_index :friendship_requests, [:requester_id, :receiver_id], unique: true
  end
end
