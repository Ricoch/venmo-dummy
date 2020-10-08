describe UserService do
  describe '.create_user' do
    let(:email)      { Faker::Internet.unique.email }
    let(:username)   { Faker::Internet.unique.user_name }
    let(:first_name) { Faker::Name.first_name }
    let(:last_name)  { Faker::Name.name }

    let(:params) do
      {
        email: email,
        username: username,
        first_name: first_name,
        last_name: last_name
      }
    end

    subject { described_class.create_user(params) }

    it 'creates a user' do
      expect { subject }.to change(User, :count).by(1)
    end

    it 'created user has the correct data' do
      subject

      user = User.last

      expect(user.email).to eq(email)
      expect(user.username).to eq(username)
      expect(user.first_name).to eq(first_name)
      expect(user.last_name).to eq(last_name)
    end
  end
end
