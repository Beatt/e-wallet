require 'rails_helper'

RSpec.describe 'Backs' do
  context 'Deposit gateway' do
    it 'should deposit successfully' do
      customer = Customer.last
      credit_card = customer.credit_cards.last
      value = 1000
      deposit_gateway = Gateway.new(credit_card, value)
      allow(deposit_gateway).to receive(:auth).and_return(true)
      params = { value_in_cents: value, customer_id: customer.id, credit_card_id: credit_card.id }
      deposit_services = DepositServices.new(params, deposit_gateway)
      deposit = deposit_services.charge
      expect(deposit).not_to be_a_new(Back::Deposit)
      expect(deposit.approved_at.present?).to be_truthy
    end

    it 'should deposit failed' do
      customer = Customer.last
      credit_card = customer.credit_cards.last
      value = 1000
      deposit_gateway = Gateway.new(credit_card, value)
      allow(deposit_gateway).to receive(:auth).and_return(false)
      params = { value_in_cents: value, customer_id: customer.id, credit_card_id: credit_card.id }
      deposit_services = DepositServices.new(params, deposit_gateway)
      deposit = deposit_services.charge
      expect(deposit).not_to be_a_new(Back::Deposit)
      expect(deposit.invalid_at.present?).to be_truthy
    end

    it 'should validate fields' do
      customer = Customer.last
      credit_card = customer.credit_cards.last
      value = 1000
      deposit_gateway = Gateway.new(credit_card, value)
      allow(deposit_gateway).to receive(:auth).and_return(true)
      params = { value_in_cents: nil, customer_id: nil, credit_card_id: nil }
      deposit_services = DepositServices.new(params, deposit_gateway)
      deposit = deposit_services.charge
      expect(deposit).not_to be_a_new(Back::Deposit)
      expect(deposit).to eq(["Customer can't be blank", "Credit card can't be blank", "Value in cents can't be blank"])
    end
  end
end