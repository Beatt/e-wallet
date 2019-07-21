require 'rails_helper'

RSpec.describe 'Deposit services' do
  let(:customer) { CreateCustomerServices.new(name: 'Gabriel', email: 'gabriel@gmail.com').create }
  let(:credit_card) { CreateCreditCardServices.new(brand: 'visa', kind: 'credit_card', expiration_date: '12/20', number: '2020321032010', cvc: '566', customer_id: @customer.id, country: 'MX').create }

  context 'when deposit successfully' do
    it 'should create a deposit' do
      value = 1000
      allow(Gateway).to receive(:auth?).and_return(true)
      params = { value_in_cents: value, customer_id: @customer.id, credit_card_id: @credit_card.id }
      deposit_services = DepositServices.new(params)
      deposit = deposit_services.process
      expect(deposit).not_to be_a_new(Back::Deposit)
      expect(deposit.approved_at.present?).to be_truthy
    end
  end

  context 'when deposit failed' do
    it 'shouldn´t create a deposit' do
      value = 1000
      allow(Gateway).to receive(:auth?).and_return(false)
      params = { value_in_cents: value, customer_id: @customer.id, credit_card_id: @credit_card.id }
      deposit = DepositServices.new(params).process
      expect(deposit).not_to be_a_new(Back::Deposit)
      expect(deposit.invalid_at.present?).to be_truthy
    end

    it 'should show errors messages' do
      allow(Gateway).to receive(:auth?).and_return(true)
      params = { value_in_cents: nil, customer_id: nil, credit_card_id: nil }
      deposit = DepositServices.new(params).process
      expect(deposit).not_to be_a_new(Back::Deposit)
      expect(deposit).to eq(["Customer can't be blank", "Credit card can't be blank", "Value in cents can't be blank"])
    end
  end
end
