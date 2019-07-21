class WithdrawServices

  def initialize(params, customer)
    @params = params
    @customer = customer
  end

  def process
    return ['Sin fondos para retirar'] unless with_funds?
    create_withdraw
    resolve_gateway_response
    @withdraw.save ? @withdraw : @withdraw.errors.full_messages
  end

  private

  def with_funds?
    @params[:value_in_cents].to_f < @customer.try(:balance)
  end

  def create_withdraw
    @withdraw ||= Back::Withdraw.new(@params)
  end

  def resolve_gateway_response
    if Gateway.auth?(credit_card, @params[:value_in_cents])
      @params[:approved_at] = Time.zone.now
    else
      @params[:invalid_at] = Time.zone.now
      @params[:error_message] = 'Hubo un problema al tratar de depositar en la tarjeta'
      @params[:error_code] = '002'
    end
  end

  def credit_card
    CreditCard.find(@params[:credit_card_id])
  rescue StandardError => e
    nil
  end
end
