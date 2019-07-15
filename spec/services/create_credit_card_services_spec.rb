require 'rails_helper'

RSpec.describe 'Credit card' do
  context 'Create' do
    it 'should create credit card successfully' do
    end
  end
end


class CreateCustomerServices

  def initialize(params)
    @params = params
  end

  def create
    credit_card = CreditCard.new(@params)
  end
end