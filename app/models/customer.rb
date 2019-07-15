class Customer < ActiveRecord::Base
  validates :name, :email, presence: true
end