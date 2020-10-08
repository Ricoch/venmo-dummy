describe FriendshipService do
  describe '.create_friendship_request' do
    let!(:user)     { create(:user) }
    let(:friend)    { create(:user) }
    let(:friend_id) { friend.id }

    subject { described_class.create_friendship_request(user, friend_id) }

    context 'when the user already sent the friend a request' do
      let!(:friend_request) { create(:friendship_request, requester: user, receiver: friend) }

      it 'does not create a new request' do
        expect { subject }.not_to change(FriendshipRequest, :count)
      end
    end

    context 'when the users are already friends' do
      before do
        FriendshipService.add_mutual_friends(user, friend)
      end

      it 'does not create a new request' do
        expect { subject }.not_to change(FriendshipRequest, :count)
      end
    end

    context 'when the friend already sent the user a request' do
      let!(:friend_request) { create(:friendship_request, requester: friend, receiver: user) }

      it 'adds the users mutually as friends' do
        expect { subject }.to change(Friendship, :count).by(2)
      end

      it 'removes the existing request' do
        expect { subject }.to change(FriendshipRequest, :count).by(-1)
      end
    end

    context 'when the user sends the request correctly' do
      it 'creates a new request' do
        expect { subject }.to change(FriendshipRequest, :count).by(1)
      end

      it 'new request is correct' do
        subject

        expect(FriendshipRequest.last.requester).to eq(user)
        expect(FriendshipRequest.last.receiver).to eq(friend)
      end
    end
  end

  describe '.accept_request' do
    let(:user)               { create(:user) }
    let(:friend)             { create(:user) }
    let(:friendship_request) { create(:friendship_request, requester: friend, receiver: user) }

    subject { described_class.accept_request(user, friendship_request) }

    context 'when the users are not friends already' do
      context 'when the friend sent the request' do
        it 'creates new friendships between the users' do
          expect { subject }.to change(Friendship, :count).by(2)
        end
      end

      context 'when the user sent the request' do
        let(:friendship_request) { create(:friendship_request, requester: user, receiver: friend) }

        it 'does not create a new friendship' do
          expect { subject }.not_to change(Friendship, :count)
        end
      end
    end

    context 'when the users are friends already' do
      before do
        FriendshipService.add_mutual_friends(user, friend)
      end

      it 'does not create a new friendship' do
        expect { subject }.not_to change(Friendship, :count)
      end
    end
  end

  describe '.remove_friend' do
    let!(:user)     { create(:user) }
    let(:friend)    { create(:user) }
    let(:friend_id) { friend.id }

    subject { described_class.remove_friend(user, friend_id) }

    context 'when the users are friends' do
      before do
        FriendshipService.add_mutual_friends(user, friend)
      end

      it 'removes the users friendships' do
        expect { subject }.to change(Friendship, :count).by(-2)
      end
    end

    context 'when the users are not friends' do
      it 'does not remove the friendships' do
        expect { subject }.not_to change(Friendship, :count)
      end
    end
  end

  describe '.add_mutual_friends' do
    let!(:user)  { create(:user) }
    let(:friend) { create(:user) }

    subject { described_class.add_mutual_friends(user, friend) }

    context 'when the users are not yet friends' do
      it 'creates new friendships between the users' do
        expect { subject }.to change(Friendship, :count).by(2)
      end

      it 'new friendships are between the correct users' do
        subject

        friendships = Friendship.last(2)

        expect(friendships.first.user_a).to eq(user)
        expect(friendships.first.user_b).to eq(friend)
        expect(friendships.second.user_a).to eq(friend)
        expect(friendships.second.user_b).to eq(user)
      end
    end
  end

  describe '.cancel_request' do
    let(:user)               { create(:user) }
    let(:friend)             { create(:user) }
    let!(:friendship_request) { create(:friendship_request, requester: friend, receiver: user) }

    subject { described_class.cancel_request(friendship_request) }

    context 'when the requester is the friend' do
      it 'removes the friendship request' do
        expect { subject }.to change(FriendshipRequest, :count).by(-1)
      end

      it 'does not create a new friendship' do
        expect { subject }.not_to change(Friendship, :count)
      end
    end

    context 'when the requester is the user' do
      let!(:friendship_request) { create(:friendship_request, requester: user, receiver: friend) }

      it 'removes the friendship request' do
        expect { subject }.to change(FriendshipRequest, :count).by(-1)
      end

      it 'does not create a new friendship' do
        expect { subject }.not_to change(Friendship, :count)
      end
    end
  end
end
