class FriendshipService
  def self.create_friendship_request(user, friend_id)
    sent_requests = user.sent_friendship_requests

    friendship = user.friendships.find_by(user_b_id: friend_id)
    friendship_request = sent_requests.find_by(receiver_id: friend_id)

    return if friendship || friendship_request || check_accept_request(user, friend_id)

    sent_requests.create!(receiver_id: friend_id)
  end

  # :reek:ControlParameter
  def self.accept_request(user, friendship_request)
    return unless friendship_request

    requester = friendship_request.requester
    receiver = friendship_request.receiver

    return if user == requester

    return if requester.friendships.find_by(user_b: receiver)

    friendship_request.transaction do
      add_mutual_friends(requester, receiver)
      friendship_request.destroy!
    end

    true
  end

  def self.remove_friend(user, friend_id)
    friendship_a = user.friendships.find_by(user_b_id: friend_id)
    friendship_b = Friendship.find_by(user_a_id: friend_id, user_b: user)

    return unless friendship_a.present? && friendship_b.present?

    [friendship_a, friendship_b].compact.each(&:destroy!)
  end

  def self.add_mutual_friends(requester, receiver)
    requester.friends << receiver
    receiver.friends << requester
  end

  def self.cancel_request(friendship_request)
    return unless friendship_request

    friendship_request.destroy!
  end

  def self.check_accept_request(user, friend_id)
    friendship_request = FriendshipRequest.find_by(requester_id: friend_id, receiver_id: user.id)

    accept_request(user, friendship_request)
  end
end
