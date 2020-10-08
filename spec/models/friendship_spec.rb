# == Schema Information
#
# Table name: friendships
#
#  id         :bigint           not null, primary key
#  user_a_id  :bigint
#  user_b_id  :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_friendships_on_user_a_id                (user_a_id)
#  index_friendships_on_user_a_id_and_user_b_id  (user_a_id,user_b_id) UNIQUE
#  index_friendships_on_user_b_id                (user_b_id)
#
require 'rails_helper'

RSpec.describe Friendship, type: :model do
  it { is_expected.to validate_presence_of(:user_a) }
  it { is_expected.to validate_presence_of(:user_b) }

  it { is_expected.to validate_uniqueness_of(:user_a_id).scoped_to(:user_b_id) }
end
