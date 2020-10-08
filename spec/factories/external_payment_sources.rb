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
FactoryBot.define do
  factory :external_payment_source do
    user
  end
end
