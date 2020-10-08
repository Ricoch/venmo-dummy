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
require 'rails_helper'

RSpec.describe FriendshipRequest, type: :model do
  it { is_expected.to validate_presence_of(:requester) }
  it { is_expected.to validate_presence_of(:receiver) }

  it { is_expected.to validate_uniqueness_of(:requester_id).scoped_to(:receiver_id) }
end
