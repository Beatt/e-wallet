class Gateway

  def initialize(credit_card, value)
    @credit_card = credit_card
    @value = value
  end

  def auth
    rand(0...10) < 7
  end
end