class WithdrawServices

  def initialize(params, customer)
    @params = params
    @customer = customer
  end

  def process
    return ['Sin fondos para retirar'] if @params[:value_in_cents].to_f > @customer.try(:balance)
    withdraw = Back::Withdraw.new(@params)
    withdraw.save ? withdraw : withdraw.errors.full_messages
  end
end
