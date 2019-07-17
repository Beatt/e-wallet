require 'rails_helper'

RSpec.describe 'Credit card' do
  context 'Create' do
    it 'should create credit card successfully' do
      secure_key = 'Hola1234'
      customer = CreateCustomerServices.new(name: 'Gabriel', email: 'gabriel@gmail.com', secure_key: secure_key).create
      crypt_services = CryptServices.new(customer.secure_key)
      params = { brand: 'visa', expiration_date: '12/20', number: '2020321032010', cvc: '666', customer_id: customer.id }
      credit_card_services = CreateCreditCardServices.new(params, crypt_services)
      credit_card = credit_card_services.create
    end
  end
end


class CreateCreditCardServices

  def initialize(params, crypt_services)
    @params = params
    @crypt_services = crypt_services
  end

  def create
    credit_card = CreditCard.new
    credit_card.brand = @params['brand']
    credit_card.country = 'MX'
    credit_card.expiration_date = @crypt_services.encrypt(@params['expiration_date'])
    credit_card.number = @crypt_services.encrypt(@params['number'])
    credit_card.cvc = @crypt_services.encrypt(@params['cvc'])
    credit_card.save ? credit_card : credit_card.errors.messages
  end
end