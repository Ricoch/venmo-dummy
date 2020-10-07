# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  email      :string
#  first_name :string           default("")
#  last_name  :string           default("")
#  username   :string           default("")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#

class User < ApplicationRecord
  has_one :external_payment_source

  has_many :friendships, foreign_key: :user_a_id, dependent: :destroy, inverse_of: :user_a
  has_many :friends, through: :friendships, source: :user_b

  has_many :sent_friendship_requests, class_name: 'FriendshipRequest',
                                      foreign_key: :requester_id,
                                      dependent: :destroy,
                                      inverse_of: :requester

  has_many :received_friendship_requests, class_name: 'FriendshipRequest',
                                          foreign_key: :receiver_id,
                                          dependent: :destroy,
                                          inverse_of: :receiver

  scope :with_balances, -> { includes(external_payment_source: :balances) }
  scope :with_friendships_and_friends, -> { includes(:friends) }

  delegate :last_balance, to: :external_payment_source, allow_nil: true

  def full_name
    return username if first_name.blank?

    "#{first_name} #{last_name}"
  end
end
