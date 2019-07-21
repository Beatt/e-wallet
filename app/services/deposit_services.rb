class DepositServices

  def initialize(params)
    @params = params
  end

  def process
    resolve_gateway_response
    create_deposit
    @deposit.save ? @deposit : @deposit.errors.full_messages
  end

  private

  def create_deposit
    @deposit ||= Back::Deposit.new(@params)
  end

  def resolve_gateway_response
    if Gateway.auth?(credit_card, @params[:value_in_cents])
      @params[:approved_at] = Time.zone.now
    else
      @params[:invalid_at] = Time.zone.now
      @params[:error_message] = 'Tarjeta sin fondos'
      @params[:error_code] = '001'
    end
  end

  def credit_card
    CreditCard.find(@params[:credit_card_id])
  rescue StandardError => e
    nil
  end
end
