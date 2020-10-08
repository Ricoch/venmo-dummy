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
FactoryBot.define do
  factory :balance do
    external_payment_source

    total  { Faker::Number.decimal(l_digits: 3).to_f }
    change { Faker::Number.decimal(l_digits: 3).to_f }
  end
end
