# == Schema Information
#
# Table name: external_payment_sources
#
#  id         :bigint           not null, primary key
#  user_id    :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_external_payment_sources_on_user_id  (user_id)
#
class ExternalPaymentSource < ApplicationRecord
  belongs_to :user

  has_many :balances, dependent: :destroy

  def last_balance
    balances.last&.total.to_f
  end

  def send_money(amount)
    remaining = last_balance - amount

    balance_charge(-remaining) if remaining.negative?

    decrease_balance(amount)

    true
  end

  def add_balance(amount)
    balances.create!(total: last_balance + amount, change: amount)
  end

  def decrease_balance(amount)
    balances.create!(total: last_balance - amount, change: -amount)
  end

  def balance_charge(amount)
    success = ExternalPaymentService.transfer_amount(amount)

    add_balance(amount) if success
  end
end
