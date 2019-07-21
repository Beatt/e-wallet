require 'rails_helper'

RSpec.describe 'Backs' do
  context 'Transfer' do

    before(:each) {
      @customer = CreateCustomerServices.new(name: 'Gabriel', email: 'gabriel@gmail.com').create
      @receive_customer = CreateCustomerServices.new(name: 'Geovanni', email: 'geovanni@gmail.com').create
      @credit_card = CreateCreditCardServices.new({ brand: 'visa', kind: 'credit_card', expiration_date: '12/20', number: '2020321032010', cvc: '566', customer_id: @customer.id, country: 'MX' }).create
    }

    it 'should transfer successfully' do
      value = 2000
      deposit_gateway = Gateway.new(@customer.credit_cards.last, value)
      allow(deposit_gateway).to receive(:auth).and_return(true)
      params = {value_in_cents: value, customer_id: @customer.id, credit_card_id: @customer.credit_cards.last.id}
      DepositServices.new(params, deposit_gateway).process

      value_in_cents = 1000
      params = {
        value_in_cents: value_in_cents,
        customer_id: @customer.id,
        account_recipient: @receive_customer.account_number
      }
      transfer = TransferServices.new(params, @customer).process
      expect(transfer).not_to be_a_new(Back::Transfer)
      expect(transfer.id.present?).to be_truthy
      value_in_cents_less_tax = value_in_cents - ((value_in_cents * transfer.tax.percentage) + transfer.tax.fixed_rate)
      expect(transfer.value_in_cents).to eq(value_in_cents_less_tax * 100)
    end

    it 'shouldn´t transfer successfully without backs' do
      params = {
        value_in_cents: @customer.balance + 1,
        customer_id: @customer.id,
        account_recipient: @receive_customer.account_number
      }
      transfer = TransferServices.new(params, @customer).process
      expect(transfer).not_to be_a_new(Back::Transfer)
      expect(transfer).to eq(['Sin fondos para transferir'])
    end

    it 'should validate customer model' do
      params = {
        value_in_cents: nil,
        customer_id: nil,
        account_recipient: nil
      }
      transfer = TransferServices.new(params, @customer).process
      expect(transfer).not_to be_a_new(Back::Transfer)
      expect(transfer).to eq(["Tax must exist", "Customer can't be blank", "Value in cents can't be blank", "Account recipient can't be blank", "Tax can't be blank"])
    end
  end
end
