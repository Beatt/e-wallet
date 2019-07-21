require 'rails_helper'

RSpec.describe 'Transfer services' do

  let(:customer) { CreateCustomerServices.new(name: 'Gabriel', email: 'gabriel@gmail.com').create }
  let(:receive_customer) { CreateCustomerServices.new(name: 'Geovanni', email: 'geovanni@gmail.com').create }
  let(:credit_card) { CreateCreditCardServices.new(brand: 'visa', kind: 'credit_card', expiration_date: '12/20', number: '2020321032010', cvc: '566', customer_id: customer.id, country: 'MX').create }

  context 'when transfer is success' do

    it 'should transfer (x <= 1,000)' do
      create_deposit(1000)

      value_in_cents = 1000
      params = {
        value_in_cents: value_in_cents,
        customer_id: customer.id,
        account_recipient: receive_customer.account_number
      }
      transfer = TransferServices.new(params, customer).process

      expect(transfer).not_to be_a_new(Back::Transfer)
      expect(transfer.id.present?).to be_truthy
      expect(transfer.value_in_cents).to eq(962 * 100)
      expect(transfer.tax_id.present?).to be_truthy
    end

    it 'should transfer (1,000 > x <= 5,000)' do
      create_deposit(4000)

      value_in_cents = 4000
      params = {
        value_in_cents: value_in_cents,
        customer_id: customer.id,
        account_recipient: receive_customer.account_number
      }
      transfer = TransferServices.new(params, customer).process

      expect(transfer).not_to be_a_new(Back::Transfer)
      expect(transfer.id.present?).to be_truthy
      expect(transfer.value_in_cents).to eq(3894 * 100)
      expect(transfer.tax_id.present?).to be_truthy
    end

    it 'should transfer (5,000 > x <= 10,000)' do
      create_deposit(9000)

      value_in_cents = 9000
      params = {
        value_in_cents: value_in_cents,
        customer_id: customer.id,
        account_recipient: receive_customer.account_number
      }
      transfer = TransferServices.new(params, customer).process

      expect(transfer).not_to be_a_new(Back::Transfer)
      expect(transfer.id.present?).to be_truthy
      expect(transfer.value_in_cents).to eq(8816 * 100)
      expect(transfer.tax_id.present?).to be_truthy
    end

    it 'should transfer (10,000 > x)' do
      create_deposit(11000)

      value_in_cents = 11000
      params = {
        value_in_cents: value_in_cents,
        customer_id: customer.id,
        account_recipient: receive_customer.account_number
      }
      transfer = TransferServices.new(params, customer).process

      expect(transfer).not_to be_a_new(Back::Transfer)
      expect(transfer.id.present?).to be_truthy
      expect(transfer.value_in_cents).to eq(10887 * 100)
      expect(transfer.tax_id.present?).to be_truthy
    end
  end

  context 'when transfer is failed' do

    it 'shouldn´t transfer' do
      params = {
        value_in_cents: customer.balance + 1,
        customer_id: customer.id,
        account_recipient: receive_customer.account_number
      }
      transfer = TransferServices.new(params, customer).process
      expect(transfer).not_to be_a_new(Back::Transfer)
      expect(transfer).to eq(['Sin fondos para transferir'])
    end

    it 'should show errors messages' do
      params = {
        value_in_cents: nil,
        customer_id: nil,
        account_recipient: nil
      }
      transfer = TransferServices.new(params, customer).process
      expect(transfer).not_to be_a_new(Back::Transfer)
      expect(transfer).to eq(["Tax must exist", "Customer can't be blank", "Value in cents can't be blank", "Account recipient can't be blank", "Tax can't be blank"])
    end
  end

  def create_deposit(value)
    allow(Gateway).to receive(:auth?).and_return(true)
    params = {value_in_cents: value, customer_id: customer.id, credit_card_id: customer.credit_cards.last.id}
    DepositServices.new(params).process
  end

end
