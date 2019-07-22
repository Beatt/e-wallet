class Customer < ActiveRecord::Base
  validates :name, :email, presence: true
  has_many :credit_cards
  has_many :back_deposits, class_name: 'Back::Deposit'
  has_many :back_transfers, class_name: 'Back::Transfer'
  has_many :back_withdraws, class_name: 'Back::Withdraw'
  has_many :backs, -> { select('backs.*, type AS kind, (value_in_cents / 100) AS value') }

  def income
    query = <<-SQL
      (type = 'Back::Deposit' AND approved_at IS NOT NULL AND customer_id = :customer_id) OR
      account_recipient = :customer_id
    SQL
    Back.where(query, customer_id: id)
        .sum('value_in_cents').to_f / 100 || 0
  end

  def outcome
    query = <<-SQL
      (type = 'Back::Withdraw' AND customer_id = :customer_id) OR
      (type = 'Back::Transfer' AND customer_id = :customer_id)
    SQL
    result = Back.where(query, customer_id: id)
        .sum('value_in_cents').to_f / 100 || 0
    result + fee
  end

  def fee
    query = <<-SQL
      (type = 'Back::Transfer' AND customer_id = :customer_id)
    SQL
    Back.joins(:general_account)
        .where(query, customer_id: id)
        .sum('general_accounts.fee').to_f || 0
  end

  def balance
    income - outcome
  end
end
