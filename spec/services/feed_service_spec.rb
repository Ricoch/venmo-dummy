describe FeedService do
  describe '.feed_for' do
    let!(:user) { create(:user) }

    subject { described_class.feed_for(user) }

    context 'when the user has friends' do
      let!(:user2) { create(:user) }
      let!(:user3) { create(:user) }
      let!(:user4) { create(:user) }
      let!(:user5) { create(:user) }

      let(:payment1) { create(:payment, sender: user, receiver: user2, created_at: 3.days.ago) }
      let(:payment2) { create(:payment, sender: user2, receiver: user3, created_at: 8.days.ago) }
      let(:payment3) { create(:payment, sender: user3, receiver: user4, created_at: 2.days.ago) }
      let(:payment4) { create(:payment, sender: user4, receiver: user5, created_at: 5.days.ago) }
      let(:payment5) { create(:payment, sender: user5, receiver: user, created_at: 6.days.ago) }

      let(:expected_ids) { [payment1.id, payment4.id, payment5.id, payment2.id] }

      before do
        FriendshipService.add_mutual_friends(user, user2)
        FriendshipService.add_mutual_friends(user2, user3)
        FriendshipService.add_mutual_friends(user3, user4)
        FriendshipService.add_mutual_friends(user4, user5)
        FriendshipService.add_mutual_friends(user5, user)

        expected_ids
      end

      context 'and there is activity' do
        it 'returns a list of payments' do
          expect(subject).to_not be_empty
        end

        it 'feed entries are the expected ones, ordered by date' do
          expect(subject.map(&:id)).to eq(expected_ids)
        end

        it 'does not include not friend related payment' do
          expect(subject).not_to include(payment3.id)
        end
      end
    end
  end
end
