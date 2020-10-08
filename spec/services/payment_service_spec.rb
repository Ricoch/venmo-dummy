describe PaymentService do
  describe '.transfer_to_friend' do
    let!(:user)      { create(:user) }
    let!(:friend)    { create(:user) }
    let!(:friend_id) { friend.id }

    let!(:user_payment_source)   { create(:external_payment_source, user: user) }
    let!(:friend_payment_source) { create(:external_payment_source, user: friend) }

    let!(:user_balance)   { create(:balance, external_payment_source: user_payment_source) }
    let!(:friend_balance) { create(:balance, external_payment_source: friend_payment_source) }

    let!(:transfer_amount) { Faker::Number.decimal(l_digits: 2).to_f }
    let!(:description)     { Faker::Lorem.sentence(6) }

    subject { described_class.transfer_to_friend(user, friend_id, transfer_amount, description) }

    context 'when the transfer is valid' do
      before do
        FriendshipService.add_mutual_friends(user, friend)
      end

      it 'creates a new payment' do
        expect { subject }.to change(Payment, :count).by(1)
      end

      it 'new payment has the correct data' do
        subject

        payment = Payment.last

        expect(payment.amount).to eq(transfer_amount)
        expect(payment.description).to eq(description)
        expect(payment.sender).to eq(user)
        expect(payment.receiver).to eq(friend)
      end

      # For these next four examples, I used this workaround instead of
      # `expect { subject }.to change { user.reload.last_balance }...`
      # because there seems to be a matcher bug related to float calculations
      # where it says `expected 38.26, got 38.26000000009` instead
      it 'decreases user balance' do
        initial_balance = user.last_balance

        subject

        final_balance = user.reload.last_balance

        expect(initial_balance).to be > final_balance
      end

      it 'decreased amount is correct' do
        initial_balance = user.last_balance

        subject

        final_balance = user.reload.last_balance

        expect((initial_balance - final_balance).round(2)).to eq(transfer_amount)
      end

      it 'increases friend balance' do
        initial_balance = friend.last_balance

        subject

        final_balance = friend.reload.last_balance

        expect(final_balance).to be > initial_balance
      end

      it 'increased amount is correct' do
        initial_balance = friend.last_balance

        subject

        final_balance = friend.reload.last_balance

        expect((final_balance - initial_balance).round(2)).to eq(transfer_amount)
      end

      context 'when the user tries to pay more than their remaining balance' do
        let(:user_balance_total) { 60 }
        let!(:transfer_amount) { 100 }
        let!(:friend_balance) { create(:balance, external_payment_source: friend_payment_source) }
        let!(:user_balance) do
          create(:balance, external_payment_source: user_payment_source, total: user_balance_total)
        end

        it 'transfers money from external payment source' do
          charge_amount = transfer_amount - user_balance_total

          expect(ExternalPaymentService)
            .to receive(:transfer_amount)
            .with(charge_amount)
            .and_return(true)

          subject
        end
      end
    end
  end
end
