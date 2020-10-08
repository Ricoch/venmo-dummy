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
require 'rails_helper'

RSpec.describe Payment, type: :model do
  let(:min_payment_amount) { ENV.fetch('MIN_PAYMENT_AMOUNT', 0).to_f }
  let(:max_payment_amount) { ENV.fetch('MAX_PAYMENT_AMOUNT', 1000).to_f }

  it { is_expected.to validate_presence_of(:sender) }
  it { is_expected.to validate_presence_of(:receiver) }
  it { is_expected.to validate_presence_of(:amount) }

  it do
    is_expected.to validate_numericality_of(:amount)
      .is_greater_than(min_payment_amount)
      .is_less_than(max_payment_amount)
  end
end
