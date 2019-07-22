class ApplicationController < ActionController::Base
  before_action :authenticate

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

  def authenticate
    return true if request.path == customers_path && request.method == 'POST'
    customer = Customer.find_by(access_token: params[:token].gsub(/\s+/, "+").to_s) if params[:token].present?
    return render json: 'Bad credentials'.to_json, status: :unauthorized if customer.nil?
    true
  end
end
