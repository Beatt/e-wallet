# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
p 'Seeding Taxes'
Tax.create!(name: 'x <= 1,000', limit_value: 1000, minimum_value: 0, percentage: '300', fixed_rate: '8')
Tax.create!(name: '1,000 > x <= 5,000', limit_value: 5000, minimum_value: 1000, percentage: '250', fixed_rate: '6')
Tax.create!(name: '5,000 > x <= 10,000', limit_value: 10000, minimum_value: 5000, percentage: '200', fixed_rate: '4')
Tax.create!(name: '10,000 > x', limit_value: 10000000, minimum_value: 10000, percentage: '100', fixed_rate: '3')

p 'Seeding customer'
customer = CreateCustomerServices.new(name: 'Gabriel', email: 'ggabriel@gmail.com').create
credit_card_params = {
  brand: 'visa',
  kind: 'credit_card',
  expiration_date: '12/24',
  number: '2020321032010',
  cvc: '566',
  customer_id: customer.id,
  country: 'MX'
}
CreateCreditCardServices.new(credit_card_params).create