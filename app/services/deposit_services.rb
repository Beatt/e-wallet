class DepositServices

  def initialize(params, deposit_gateway)
    @params = params
    @deposit_gateway = deposit_gateway
  end

  def process
    resolve_gateway_response
    back = Back::Deposit.new(@params)
    back.save ? back : back.errors.full_messages
  end

  private

  def resolve_gateway_response
    if @deposit_gateway.auth
      @params[:approved_at] = Time.zone.now
    else
      @params[:invalid_at] = Time.zone.now
      @params[:error_message] = 'Tarjeta sin fondos'
      @params[:error_code] = '001'
    end
  end
end
