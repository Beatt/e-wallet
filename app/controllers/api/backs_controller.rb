module Api
  class BacksController < ApplicationController
    skip_before_action :verify_authenticity_token

    def index
      backs = customer.backs
      render json: backs, status: 200
    end

    def create
      deposit_gateway = Gateway.new(@credit_card, params[:back][:value_in_cents])
      params[:back][:customer_id] = customer.id
      back = case params[:type]
             when 'deposit'
               DepositServices.new(back_params, deposit_gateway).charge
             when 'transfer'
               TransferServices.new(back_params, customer).process
             when 'withdraw'
               nil
             else
               ['Type no permitido']
             end
      render json: back, status: 200
    end

    private

    def credit_card
      customer.credit_cards.where(id: params[:back][:credit_card_id])
    end

    def customer
      Customer.find_by(account_number: params[:customer_id])
    end

    def back_params
      params.require(:back).permit(:value_in_cents, :credit_card_id, :customer_id, :account_recipient)
    end
  end
end
