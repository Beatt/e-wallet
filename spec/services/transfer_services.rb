require 'rails_helper'

RSpec.describe 'Backs' do
  context 'Transfer' do

    before(:each) {
      @customer = CreateCustomerServices.new(name: 'Gabriel', email: 'gabriel@gmail.com', secure_key: 'Hola1234').create
      @receive_customer = CreateCustomerServices.new(name: 'Geovanni', email: 'geovanni@gmail.com', secure_key: 'Hola1234').create
    }

    it 'should transfer successfully' do
      value = 2000
      deposit_gateway = Gateway.new(@customer.credit_cards.last, value)
      allow(deposit_gateway).to receive(:auth).and_return(true)
      params = { value_in_cents: value, customer_id: @customer.id, credit_card_id: @customer.credit_cards.last.id }
      deposit_services = DepositServices.new(params, deposit_gateway)
      deposit_services.charge

      params = {
        value_in_cents: 1000,
        customer_id: @customer.id,
        account_recipient: @receive_customer.id
      }
      transfer = TransferServices.new(params).process
      expect(transfer).not_to be_a_new(Back::Transfer)
      expect(transfer.id.present?).to be_truthy
    end

    it 'shouldn´t transfer successfully without backs' do
      params = {
        value_in_cents: @customer.balance + 1,
        customer_id: @customer.id,
        account_recipient: @receive_customer.id
      }
      transfer = TransferServices.new(params).process
      expect(transfer).not_to be_a_new(Back::Transfer)
      expect(transfer).to eq(['Sin fondos'])
    end

    it 'should validate model customer id' do
      params = {
        value_in_cents: nil,
        customer_id: nil,
        account_recipient: nil
      }
      transfer = TransferServices.new(params).process
      expect(transfer).not_to be_a_new(Back::Transfer)
      expect(transfer).to eq(["Customer id obligatorio"])
    end
  end
end
