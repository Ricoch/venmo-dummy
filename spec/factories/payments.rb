# == Schema Information
#
# Table name: payments
#
#  id          :bigint           not null, primary key
#  sender_id   :bigint
#  receiver_id :bigint
#  description :string
#  amount      :float            not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_payments_on_receiver_id                (receiver_id)
#  index_payments_on_sender_id                  (sender_id)
#  index_payments_on_sender_id_and_receiver_id  (sender_id,receiver_id)
#
FactoryBot.define do
  factory :payment do
    sender   factory: :user
    receiver factory: :user
    amount      { Faker::Number.decimal(l_digits: 3).to_f }
    description { Faker::Lorem.sentence(6) }
  end
end
