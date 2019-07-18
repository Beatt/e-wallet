class Tax < ActiveRecord::Base
  def self.between_minimum_limit_value(value)
    Tax.where(':value > minimum_value AND :value <= limit_value', value: value).first
  end
end