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

describe User do
  describe 'validations' do
    subject { build :user }

    context 'when was created with regular login' do
      subject { build :user }
      it { is_expected.to validate_uniqueness_of(:email).case_insensitive.scoped_to(:provider) }
      it { is_expected.to validate_presence_of(:email) }
    end
  end

  context 'when was created with regular login' do
    let!(:user) { create(:user) }
    let(:full_name) { user.full_name }

    it 'returns the correct name' do
      expect(full_name).to eq(user.username)
    end
  end

  context 'when user has first_name' do
    let!(:user) { create(:user, first_name: 'John', last_name: 'Doe') }

    it 'returns the correct name' do
      expect(user.full_name).to eq('John Doe')
    end
  end

  describe '.from_social_provider' do
    context 'when user does not exists' do
      let(:params) { attributes_for(:user) }

      it 'creates the user' do
        expect {
          User.from_social_provider('provider', params)
        }.to change { User.count }.by(1)
      end
    end

    context 'when the user exists' do
      let!(:user)  { create(:user, provider: 'provider', uid: 'user@example.com') }
      let(:params) { attributes_for(:user).merge('id' => 'user@example.com') }

      it 'returns the given user' do
        expect(User.from_social_provider('provider', params))
          .to eq(user)
      end
    end
  end
end
