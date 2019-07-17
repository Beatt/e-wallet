class CreditCard < ActiveRecord::Base
  validates :number, :expiration_date, :last4, :country, :cvc, :brand, :kind, :customer_id, presence: true
end