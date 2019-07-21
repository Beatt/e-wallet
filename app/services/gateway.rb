class Gateway
  class << self
    def auth?(credit_card, value)
      rand(0...10) < 7
    end
  end
end
