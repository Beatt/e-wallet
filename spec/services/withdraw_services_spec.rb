require 'rails_helper'

RSpec.describe 'Back' do
  context 'Withdraw' do

    before(:each) {
      @customer = CreateCustomerServices.new(name: 'Gabriel', email: 'gabriel@gmail.com').create
      @params = {
        brand: 'visa',
        kind: 'credit_card',
        expiration_date: '12/20',
        number: '2020321032010',
        cvc: '566',
        customer_id: @customer.id,
        country: 'MX'
      }
      CreateCreditCardServices.new(@params).create
    }

    it 'should withdraw funds successfully' do
      value = 2000
      allow(Gateway).to receive(:auth?).and_return(true)
      params = { value_in_cents: value, customer_id: @customer.id, credit_card_id: @customer.credit_cards.last.id }
      deposit_services = DepositServices.new(params)
      deposit_services.process

      params = {
        value_in_cents: 1000,
        customer_id: @customer.id,
        credit_card_id: @customer.credit_cards.last.id
      }
      allow(Gateway).to receive(:auth?).and_return(true)
      withdraw = WithdrawServices.new(params, @customer).process
      expect(withdraw).not_to be_a_new(Back::Withdraw)
      expect(withdraw.id.present?).to be_truthy
    end

    it 'shouldn´t withdraw funds successfully' do
      params = {
        value_in_cents: @customer.balance + 1,
        customer_id: @customer.id,
        credit_card_id: @customer.credit_cards.last.id
      }
      withdraw = WithdrawServices.new(params, @customer).process
      expect(withdraw).to eq(['Sin fondos para retirar'])
    end

    it 'should validate withdraw model' do
      params = {
        value_in_cents: nil,
        customer_id: nil,
        credit_card_id: nil
      }
      allow(Gateway).to receive(:auth?).and_return(true)
      withdraw = WithdrawServices.new(params, @customer).process
      expect(withdraw).to eq(["Customer can't be blank", "Value in cents can't be blank", "Credit card can't be blank"])
    end
  end
end
