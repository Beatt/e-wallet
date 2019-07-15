module Api
  class CustomersController < ApplicationController
    skip_before_action :verify_authenticity_token

    def index; end

    def show
      customer = find_customer
      render_response(customer)
    end

    def create
      customer = CreateCustomerServices.new(customer_params).create
      render json: customer
    end

    def update; end

    def delete; end

    private

    def customer_params
      params.require(:customer).permit(:name, :email)
    end

    def find_customer
      Customer.find(params[:id])
    rescue ActiveRecord::RecordNotFound => _error
      nil
    end

    def render_response(customer)
      return render json: { body: "No se encontro el número de cuenta #{params[:id]}", status: :not_found } if customer.nil?
      render json: customer
    end
  end
end
