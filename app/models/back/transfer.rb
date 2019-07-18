class Back::Transfer < Back
  validates :type, :customer_id, :value_in_cents, presence: true
end