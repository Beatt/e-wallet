class Customer < ActiveRecord::Base
  validates :name, :email, :secure_key, presence: true
end