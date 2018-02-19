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
      # Parses info about customer id, email, and address
      list.each do |row|
        custormer_id = row[0].to_i
        customer_email = row[1]
        address = row[2..4].join(", ") + " " + row[5]
        # Creates a new customer instance. Adds instance to array of Customer instances
        new_customer = Grocery::Customer.new(custormer_id, customer_email, address)
        all_customers << new_customer
      end
      return all_customers
    end

    # Searches customer_list array for one Customer with customer_id. If customer does not exist, returns nil
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
