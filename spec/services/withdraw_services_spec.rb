require 'rails_helper'

RSpec.describe 'Withdraw services' do

  let(:customer) { CreateCustomerServices.new(name: 'Gabriel', email: 'gabriel@gmail.com').create }

  context 'when withdraw fund successfully' do

    it 'should create a withdraw' do
      CreateCreditCardServices.new(
        brand: 'visa',
        kind: 'credit_card',
        expiration_date: '12/20',
        number: '2020321032010',
        cvc: '566',
        customer_id: customer.id,
        country: 'MX'
      ).create

      params = {
        value_in_cents: 1000,
        customer_id: customer.id,
        credit_card_id: customer.credit_cards.last.id
      }

      allow(Gateway).to receive(:auth?).and_return(true)
      withdraw = WithdrawServices.new(params, customer).process
      expect(withdraw).not_to be_a_new(Back::Withdraw)
      expect(withdraw.id.present?).to be_truthy
    end
  end

  context 'when withdraw fund fail' do
    it 'shouldn´t create a withdraw' do
      params = {
        value_in_cents: customer.balance + 1,
        customer_id: customer.id,
        credit_card_id: customer.credit_cards.last.id
      }
      withdraw = WithdrawServices.new(params, customer).process
      expect(withdraw).to eq(['Sin fondos para retirar'])
    end

    it 'should show errors messages' do
      params = {
        value_in_cents: nil,
        customer_id: nil,
        credit_card_id: nil
      }
      allow(Gateway).to receive(:auth?).and_return(true)
      withdraw = WithdrawServices.new(params, customer).process
      expect(withdraw).to eq(["Customer can't be blank", "Value in cents can't be blank", "Credit card can't be blank"])
    end
  end

  def create_deposit
    value = 2000
    allow(Gateway).to receive(:auth?).and_return(true)
    params = { value_in_cents: value, customer_id: customer.id, credit_card_id: customer.credit_cards.last.id }
    deposit_services = DepositServices.new(params)
    deposit_services.process
  end
end
