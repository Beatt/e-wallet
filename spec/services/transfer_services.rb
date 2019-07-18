require 'rails_helper'

RSpec.describe 'Backs' do
  context 'Transfer' do
    it 'should transfer successfully' do
      receive_customer = CreateCustomerServices.new(name: 'Gabriel', email: 'gabriel@gmail.com', secure_key: 'Hola1234').create
      customer = CreateCustomerServices.new(name: 'Geovanni', email: 'geovanni@donadora.mx', secure_key: 'Hola1234').create
      crypt_services = CryptServices.new(customer.secure_key)
      credit_card = CreateCreditCardServices.new({ brand: 'visa', kind: 'credit_card', expiration_date: '12/20', number: '2020321032010', cvc: '566', customer_id: customer.id, country: 'MX' }, crypt_services).create
      params = {
        value_in_cents: 1000,
        customer_id: receive_customer.id,
        account_recipient: customer.id,
        credit_card_id: credit_card.id
      }
      transfer = TransferServices.new(params).transfer
      expect(transfer).not_to be_a_new(Back::Transfer)
      expect(transfer.id.present?).to be_truthy
    end
  end
end

class TransferServices

  def initialize(params)
    @params = params
  end

  def transfer
    transfer = Back::Transfer.new(@params)
    transfer.save ? transfer : transfer.errors.full_messages
  end
end