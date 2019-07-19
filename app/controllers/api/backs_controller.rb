module Api
  class BacksController < ApplicationController
    skip_before_action :verify_authenticity_token

    def index
      return render json: balance_json if params[:scope] == 'balance'
      backs = customer.backs
      render json: backs, status: 200
    end

    def create
      gateway = Gateway.new(@credit_card, params[:back][:value_in_cents])
      params[:back][:customer_id] = customer.id
      back = case params[:type]
             when 'deposit'
               DepositServices.new(back_params, gateway).process
             when 'transfer'
               TransferServices.new(back_params, customer).process
             when 'withdraw'
               WithdrawServices.new(back_params, customer).process
             else
               ['Type no permitido']
             end
      render json: back, status: 200
    end

    private

    def balance_json
      { balance: customer.balance, income: customer.income, outcome: customer.outcome }
    end

    def credit_card
      customer.credit_cards.where(id: params[:back][:credit_card_id])
    end

    def back_params
      params.require(:back).permit(:value_in_cents, :credit_card_id, :customer_id, :account_recipient)
    end
  end
end
