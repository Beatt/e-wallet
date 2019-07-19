class TransferServices

  def initialize(params, customer)
    @params = params
    @customer = customer
  end

  def process
    return ['Sin fondos para transferir'] if @params[:value_in_cents].to_f > @customer.try(:balance)
    assign_account_recipient
    transfer = Back::Transfer.new(@params)
    return transfer.errors.full_messages unless transfer.save
    create_general_account(transfer)
    transfer
  end

  private

  def assign_account_recipient
    @params[:account_recipient] = customer_recipient.try(:id)
  end

  def customer_recipient
    Customer.find_by(account_number: @params[:account_recipient])
  end

  def create_general_account(transfer)
    tax = Tax.between_minimum_limit_value(@params[:value_in_cents].to_f)
    GeneralAccount.create(back_id: transfer.id, taxe_id: tax.id)
  end
end