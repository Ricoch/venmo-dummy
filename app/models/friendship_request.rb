# == Schema Information
#
# Table name: friendship_requests
#
#  id           :bigint           not null, primary key
#  requester_id :bigint
#  receiver_id  :bigint
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_friendship_requests_on_receiver_id                   (receiver_id)
#  index_friendship_requests_on_requester_id                  (requester_id)
#  index_friendship_requests_on_requester_id_and_receiver_id  (requester_id,receiver_id) UNIQUE
#
class FriendshipRequest < ApplicationRecord
  belongs_to :requester, class_name: 'User'
  belongs_to :receiver, class_name: 'User'

  validates :requester, presence: true
  validates :receiver, presence: true

  validates :requester_id, uniqueness: { scope: :receiver_id }
end
