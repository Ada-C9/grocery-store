require 'csv'
require 'awesome_print'
require_relative 'order.rb'

module Grocery

  class Customer
    attr_reader :id, :email, :address

    def initialize(id, email, address)
      @id = id
      @email = email
      @address = address
    end

    def self.all
      list = []
      CSV.open("support/customers.csv", 'r').each do |row|
        list << row
      end

      all_customers = []
      list.each do |row|
        custormer_id = row[0].to_i
        customer_email = row[1]
        address = row[2..4].join(", ") + " " + row[5]
        new_customer = Grocery::Customer.new(custormer_id, customer_email, address)
        all_customers << new_customer
      end
      return all_customers
    end

    def self.find(customer_id)
      customer_list = Customer.all
      customer_list.each do |customer|
        if customer.id == customer_id
          return customer
        end
      end
      return nil
    end
  end

end

# one_customer = Grocery::Customer.find(1)
# ap one_customer.address

# list = []
# CSV.open("../support/customers.csv", 'r').each do |row|
#   list << row
# end
#
# all_customers = []
# list.each do |row|
#   custormer_id = row[0]
#   # ap custormer_id
#   customer_email = row[1]
#   # ap customer_email
#   address = row[2..4].join(", ") + " " + row[5]
#   # ap address
#   new_customer = Grocery::Customer.new(custormer_id, customer_email, address)
#   all_customers << new_customer
# end

# ap all_customers
