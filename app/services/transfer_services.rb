class TransferServices

  def initialize(params)
    @params = params
  end

  def process
    return ['Customer id obligatorio'] if @params[:customer_id].nil?
    return ['Sin fondos'] if @params[:value_in_cents].to_f > customer.balance
    transfer = Back::Transfer.new(@params)
    return transfer.errors.full_messages unless transfer.save
    create_general_account(transfer)
    transfer
  end

  private

  def customer
    Customer.find(@params[:customer_id])
  end

  def create_general_account(transfer)
    tax = Tax.between_minimum_limit_value(@params[:value_in_cents].to_f)
    GeneralAccount.create(back_id: transfer.id, taxe_id: tax.id)
  end
end