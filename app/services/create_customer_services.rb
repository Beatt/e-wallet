class CreateCustomerServices

  def initialize(params)
    @params = params
  end

  def create
    customer = customer_by_email
    return customer if customer.present?
    customer = Customer.new(@params)
    customer.account_number = generate_account_number
    customer.save ? customer : customer.errors.full_messages
  end

  private

  def customer_by_email
    return Customer.find_by(email: @params[:email]) if @params[:email].present?
    nil
  end

  def generate_account_number
    rand(100000..999999)
  end
end