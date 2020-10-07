class UserService
  def create_user(params)
    User.create!(params)
  end
end
