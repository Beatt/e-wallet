module Api
  class CreditCardsController < ApplicationController
    skip_before_action :verify_authenticity_token

    def index
      credit_cards = customer.credit_cards
      render json: credit_cards
    end

    def show
      credit_card = CreditCard.find(params[:id])
      render json: credit_card
    end

    def create
      params[:credit_card][:customer_id] = customer.id
      credit_card = CreateCreditCardServices.new(credit_card_params).create
      render json: credit_card
    end

    private

    def credit_card_params
      params.require(:credit_card).permit(:brand, :kind, :expiration_date, :number, :cvc, :customer_id)
    end

  end
end