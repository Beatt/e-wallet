module Api
  class CreditCardsController < ApplicationController
    skip_before_action :verify_authenticity_token

    def index
      credit_cards = customer.credit_cards
      render json: credit_cards, status: 201
    end

    def show
      credit_card = CreditCard.find(params[:id])
      render json: credit_card, status: 201
    end

    def create
      crypt_services = CryptServices.new(customer.secure_key)
      params[:credit_card][:customer_id] = customer.id
      credit_card = CreateCreditCardServices.new(credit_card_params, crypt_services).create
      render json: credit_card, status: 200
    end

    private

    def credit_card_params
      params.require(:credit_card).permit(:brand, :kind, :expiration_date, :number, :cvc, :customer_id)
    end

  end
end