class Back < ActiveRecord::Base
  before_save :set_value
  has_one :general_account

  scope :approved, -> { where.not(approved_at: nil) }
  scope :failed, -> { where.not(invalid_at: nil) }

  def set_value
    self.value_in_cents = self.value_in_cents * 100
  end
end
