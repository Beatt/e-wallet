class TransferServices

  def initialize(params, customer)
    @params = params
    @customer = customer
    @value_in_cents = params[:value_in_cents]
  end

  def process
    return ['Sin fondos para transferir'] unless with_funds?
    assign_values
    create_transfer
    return @transfer.errors.full_messages unless @transfer.save
    create_general_account
  end

  private

  def with_funds?
    @value_in_cents <= @customer.try(:balance)
  end

  def assign_values
    assign_account_recipient
    assign_tax
  end

  def create_transfer
    @transfer ||= Back::Transfer.new(@params)
  end

  def assign_account_recipient
    @params[:account_recipient] = customer_recipient.id
  rescue StandardError => e
    nil
  end

  def customer_recipient
    Customer.find_by(account_number: @params[:account_recipient])
  end

  def assign_tax
    create_tax
    @params[:value_in_cents] = value_in_cents_less_tax
    @params[:tax_id] = @tax.id
  rescue StandardError => e
    nil
  end

  def create_tax
    @tax ||= Tax.between_minimum_limit_value(@value_in_cents.to_f)
  end

  def value_in_cents_less_tax
    @value_in_cents - fee
  end

  def fee
    ((@value_in_cents * @tax.percentage_value) + @tax.fixed_rate)
  end

  def create_general_account
    GeneralAccount.create(back_id: @transfer.id, fee: fee)
    @transfer
  end
end