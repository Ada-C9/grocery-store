require 'CSV'
require 'awesome_print'
#require '../lib/order.rb'
module Grocery
  class Customer
    attr_reader :customer_id,:email,:address
    def initialize(customer_id,email,address)
      @customer_id = customer_id
      @email = email
      @address = address

    end
    def self.all
      all_customers = []
      CSV.read('../support/customers.csv').each do |customer|
        #puts customer.inspect

        customer_id = customer[0].to_i
        email = customer[1]
        address = {}
        address[:street] = customer[2]
        address[:city] = customer[3]
        address[:state] =customer[4]
        address[:zip] = customer[5]
        #puts address

        new_customer = Customer.new(customer_id,email,address)
        all_customers << new_customer

      end

        return all_customers

    end

    def self.find(customer_id)
      self.all.each do |customer|
        if customer.customer_id == customer_id
          return customer
        end

      end
      raise ArgumentError.new("Customer id #{id} does not exist")
    end
  end
end

Grocery::Customer.all
ap Grocery::Customer.find(3)
