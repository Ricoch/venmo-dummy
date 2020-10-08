class UserService
  def self.create_user(params)
    User.create!(params)
  end
end
