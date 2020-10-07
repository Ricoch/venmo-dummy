# == Schema Information
#
# Table name: balances
#
#  id                         :bigint           not null, primary key
#  external_payment_source_id :bigint
#  change                     :decimal(, )
#  total                      :decimal(, )
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#
# Indexes
#
#  index_balances_on_external_payment_source_id  (external_payment_source_id)
#
class Balance < ApplicationRecord
  belongs_to :external_payment_source

  validates :change, presence: true
  validates :total, presence: true
end
