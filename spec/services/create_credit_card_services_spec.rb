require 'rails_helper'

RSpec.describe 'Credit card' do
  context 'Create' do

    before(:each) {
      @secure_key = 'Hola1234'
      @customer = CreateCustomerServices.new(name: 'Gabriel', email: 'gabriel@gmail.com', secure_key: @secure_key).create
      @crypt_services = CryptServices.new(@customer.secure_key)
      @params = { brand: 'visa', kind: 'credit_card', expiration_date: '12/20', number: '2020321032010', cvc: '566', customer_id: @customer.id, country: 'MX' }
    }

    it 'should create credit card successfully' do
      credit_card = CreateCreditCardServices.new(@params, @crypt_services).create
      expect(credit_card).not_to be_a_new(CreditCard)
    end

    it 'shouldn´t add the same credit card' do
      credit_card = CreateCreditCardServices.new(@params, @crypt_services).create
      expect(credit_card).not_to be_a_new(CreditCard)
      expect(CreditCard.count).to eq(1)
    end

    it 'should add [n] credit cards by customer' do
      @params[:number] = '2020321034120'
      credit_card = CreateCreditCardServices.new(@params, @crypt_services).create
      expect(credit_card).not_to be_a_new(CreditCard)
      expect(CreditCard.count).to be > 1
    end

    it 'should return errors' do
      @params[:number] = nil
      @params[:customer_id] = nil
      @params[:expiration_date] = nil
      @params[:cvc] = nil
      credit_card = CreateCreditCardServices.new(@params, @crypt_services).create
      expect(credit_card).to eq(["Number can't be blank", "Expiration date can't be blank", "Last4 can't be blank", "Cvc can't be blank", "Customer can't be blank"])
    end
  end
end


class CreateCreditCardServices

  def initialize(params, crypt_services)
    @params = params
    @crypt_services = crypt_services
    @params[:last4] = @params[:number].last(4) if @params[:number].present?
  end

  def create
    credit_card = initial_credit_card
    encrypt_fields(credit_card)
    credit_card.save ? credit_card : credit_card.errors.full_messages
  end

  private

  def initial_credit_card
    credit_card = CreditCard.find_by(last4: @params[:last4])
    credit_card.nil? ? CreditCard.new(@params) : credit_card
  end

  def encrypt_fields(credit_card)
    credit_card.expiration_date = @crypt_services.encrypt(@params[:expiration_date]) if @params[:expiration_date]
    credit_card.number = @crypt_services.encrypt(@params[:number]) if @params[:number]
    credit_card.cvc = @crypt_services.encrypt(@params[:cvc]) if @params[:cvc]
  end
end