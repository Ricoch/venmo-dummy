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
FactoryBot.define do
  factory :friendship do
    user_a factory: :user
    user_b factory: :user
  end
end
