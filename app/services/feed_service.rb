class FeedService
  def self.feed_for(user)
    friend_ids = user.friends.select(:id)

    scope = Payment.includes(:sender, :receiver)

    scope.where(sender_id: friend_ids)
         .or(scope.where(receiver_id: friend_ids))
         .order(created_at: :desc)
  end
end
