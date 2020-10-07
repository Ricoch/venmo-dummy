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







  def full_name
    return username if first_name.blank?

    "#{first_name} #{last_name}"
  end
end
