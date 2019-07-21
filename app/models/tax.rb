class Tax < ActiveRecord::Base
  def self.between_minimum_limit_value(value)
    Tax.where(':value > minimum_value AND :value <= limit_value', value: value).first
  end

  def percentage_value
    (percentage.to_f / 100) / 100
  end
end