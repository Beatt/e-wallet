class CreateCreditCardServices

  def initialize(params)
    @params = params
    @params[:last4] = resolve_last4
  end

  def create
    credit_card = initial_credit_card
    encrypt_fields(credit_card)
    credit_card.save ? credit_card : credit_card.errors.full_messages
  end

  private

  def resolve_last4
    @params[:number].last(4) if @params[:number].present?
  end

  def initial_credit_card
    credit_card = CreditCard.find_by(last4: @params[:last4])
    credit_card.nil? ? CreditCard.new(@params) : credit_card
  end

  def encrypt_fields(credit_card)
    credit_card.expiration_date = CryptServices.encrypt(@params[:expiration_date]) if @params[:expiration_date]
    credit_card.number = CryptServices.encrypt(@params[:number]) if @params[:number]
    credit_card.cvc = CryptServices.encrypt(@params[:cvc]) if @params[:cvc]
  end
end