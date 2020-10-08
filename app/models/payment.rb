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
class Payment < ApplicationRecord
  MIN_PAYMENT_AMOUNT = ENV.fetch('MIN_PAYMENT_AMOUNT', 0).to_f
  MAX_PAYMENT_AMOUNT = ENV.fetch('MAX_PAYMENT_AMOUNT', 1000).to_f

  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'

  validates :sender, :receiver, :amount, presence: true

  validates :amount, numericality: { greater_than: MIN_PAYMENT_AMOUNT,
                                     less_than: MAX_PAYMENT_AMOUNT }

  validate :user_is_friend, on: :create

  paginates_per 10

  def full_description
    sender_name = sender.full_name
    receiver_name = receiver.full_name

    date = created_at.strftime('%m/%d/%y')

    "#{sender_name} paid #{receiver_name} on #{date} - #{description}"
  end

  def user_is_friend
    return if sender&.friends&.include?(receiver)

    errors.add(:payment, I18n.t('api.errors.payment.must_be_to_a_friend'))
  end
end
