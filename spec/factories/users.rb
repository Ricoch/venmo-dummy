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

FactoryBot.define do
  factory :user do
    email    { Faker::Internet.unique.email }
    username { Faker::Internet.unique.user_name }
  end
end
