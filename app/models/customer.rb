class Customer < ActiveRecord::Base
  validates :name, :email, :secure_key, presence: true
  has_many :credit_cards
  has_many :back_deposits, class_name: 'Back::Deposit'
  has_many :back_transfers, class_name: 'Back::Transfer'
  has_many :back_withdraws, class_name: 'Back::Withdraw'
end