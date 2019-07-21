require 'rails_helper'

RSpec.describe 'Credit card' do

  let(:customer) { CreateCustomerServices.new(name: 'Gabriel', email: 'gabriel@gmail.com').create }
  let(:params) { { brand: 'visa', kind: 'credit_card', expiration_date: '12/20', number: '2020321032010', cvc: '566', customer_id: customer.id, country: 'MX' } }

  context 'when create successfully' do

    it 'should create a credit card' do
      credit_card = CreateCreditCardServices.new(params).create
      expect(credit_card).not_to be_a_new(CreditCard)
    end

    it 'shouldn´t add the same credit card' do
      credit_card_expect = CreditCard.find_by(last4: params[:last4])
      credit_card = CreateCreditCardServices.new(params).create
      expect(credit_card).not_to be_a_new(CreditCard)
      expect(credit_card_expect) == credit_card
    end

    it 'should add [n] credit cards by customer' do
      params[:number] = '2020321034120'
      credit_card = CreateCreditCardServices.new(params).create
      expect(credit_card).not_to be_a_new(CreditCard)
      expect(CreditCard.count).to be > 1
    end
  end

  context 'when create failed' do
    it 'should show errors messages' do
      params[:number] = nil
      params[:customer_id] = nil
      params[:expiration_date] = nil
      params[:cvc] = nil
      credit_card = CreateCreditCardServices.new(params).create
      expect(credit_card).to eq(["Number can't be blank", "Expiration date can't be blank", "Last4 can't be blank", "Cvc can't be blank", "Customer can't be blank"])
    end
  end
end
