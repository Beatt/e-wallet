class Back::Withdraw < Back
  validates :type, :customer_id, :value_in_cents, :credit_card_id, presence: true
end