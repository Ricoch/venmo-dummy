class PaymentService
  def self.transfer_to_friend(user, friend_id, amount, description)
    friend = User.with_balances.find(friend_id)

    perform_transfer(user, friend, amount, description)
  end

  def self.perform_transfer(user, friend, amount, description)
    external_payment_source = user.external_payment_source
    user_payment_account = friend.external_payment_source

    transfer_service = MoneyTransferService.new(external_payment_source, user_payment_account)

    payment = Payment.new(sender: user, receiver: friend, amount: amount, description: description)

    payment.transaction do
      transfer_service.transfer(amount)
      payment.save!
    end
  end
end
