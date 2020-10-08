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
FactoryBot.define do
  factory :friendship_request do
    requester factory: :user
    receiver  factory: :user
  end
end
