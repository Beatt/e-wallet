require 'rails_helper'

RSpec.describe 'Customer' do
  context 'Create' do

    subject(:params) { { name: 'Gabriel', email: 'ggabriel@gmail.com', secure_key: 'hi' }}

    it 'should create customer successfully' do
      customer = CreateCustomerServices.new(params).create
      expect(customer).not_to be_a_new(Customer)
    end

    it 'should create number account' do
      customer = CreateCustomerServices.new(params).create
      expect(customer.account_number.to_i.is_a? Integer).to be_truthy
    end

    it 'shouldn´t create a new customer with the same email' do
      customer_1 = CreateCustomerServices.new(params).create
      customer_2 = CreateCustomerServices.new(params).create

      expect(customer_1).not_to be_a_new(Customer)
      expect(customer_2).to eq(customer_1)
    end

    it 'should show errors when customer save failed' do
      customer = CreateCustomerServices.new(name: 'Juan', email: nil).create
      expect(customer).to eq(["Email can't be blank", "Secure key can't be blank"])
    end

  end
end