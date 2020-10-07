class FriendshipService
  def self.create_friendship_request(user, friend_id)
    sent_requests = user.sent_friendship_requests

    friendship_request = sent_requests.find_by(receiver_id: friend_id)

    return if friendship_request

    sent_requests.create!(receiver_id: friend_id)
  end

  def self.cancel_request(friendship_request)
    return unless friendship_request

    friendship_request.destroy!
  end
end
