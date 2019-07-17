class Tax < ActiveRecord::Base
  def self.between_minimum_limit_value(value)
    Tax.where('? > minimum_value AND ? <= limit_value', value, value)
  end
end