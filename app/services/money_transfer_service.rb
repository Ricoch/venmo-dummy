class MoneyTransferService
  attr_reader :external_payment_source, :receiving_user_source

  def initialize(external_payment_source, receiving_user_payment_source)
    @external_payment_source = external_payment_source
    @receiving_user_source = receiving_user_payment_source
  end

  def transfer(amount)
    external_payment_source.try(:send_money, amount)
    receiving_user_source.try(:add_balance, amount)
  end
end
