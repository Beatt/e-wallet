class Back::Transfer < Back
  belongs_to :tax
  validates :type, :customer_id, :value_in_cents, :account_recipient, :tax_id, presence: true
end