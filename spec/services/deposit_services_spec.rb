require 'rails_helper'

RSpec.describe 'Backs' do
  context 'Deposit gateway' do

    before(:each) {
      @customer = CreateCustomerServices.new(name: 'Gabriel', email: 'gabriel@gmail.com').create
      @credit_card = CreateCreditCardServices.new({ brand: 'visa', kind: 'credit_card', expiration_date: '12/20', number: '2020321032010', cvc: '566', customer_id: @customer.id, country: 'MX' }).create
    }

    it 'should deposit successfully' do
      value = 1000
      allow(Gateway).to receive(:auth?).and_return(true)
      params = { value_in_cents: value, customer_id: @customer.id, credit_card_id: @credit_card.id }
      deposit_services = DepositServices.new(params)
      deposit = deposit_services.process
      expect(deposit).not_to be_a_new(Back::Deposit)
      expect(deposit.approved_at.present?).to be_truthy
    end

    it 'should deposit failed' do
      value = 1000
      allow(Gateway).to receive(:auth?).and_return(false)
      params = { value_in_cents: value, customer_id: @customer.id, credit_card_id: @credit_card.id }
      deposit_services = DepositServices.new(params)
      deposit = deposit_services.process
      expect(deposit).not_to be_a_new(Back::Deposit)
      expect(deposit.invalid_at.present?).to be_truthy
    end

    it 'should validate fields' do
      allow(Gateway).to receive(:auth?).and_return(true)
      params = { value_in_cents: nil, customer_id: nil, credit_card_id: nil }
      deposit_services = DepositServices.new(params)
      deposit = deposit_services.process
      expect(deposit).not_to be_a_new(Back::Deposit)
      expect(deposit).to eq(["Customer can't be blank", "Credit card can't be blank", "Value in cents can't be blank"])
    end
  end
end