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
require 'rails_helper'

RSpec.describe Balance, type: :model do
  it { is_expected.to validate_presence_of(:total) }
  it { is_expected.to validate_presence_of(:change) }
end
