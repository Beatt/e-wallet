class ApplicationController < ActionController::Base
  def home
    render json: 'e-wallet por Gabriel G.'
  end

  def customer
    customer = Customer.find_by(account_number: params[:customer_id])
    raise404 if customer.nil?
    customer
  end

  def raise404
    request.format = :json
    raise ActionController::RoutingError.new('Not Found')
  end
end
