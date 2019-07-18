class Back::Deposit < Back
  validates :type, :customer_id, :credit_card_id, :value_in_cents, presence: true
end