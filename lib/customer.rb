require 'csv'
require 'awesome_print'

module Grocery
  class Customer

    attr_reader :id, :email, :address

    def initialize(customer_id, email, address)
      @id = customer_id
      @email = email
      @address = address
    end

    def self.all
      all_customers = []
      CSV.read("/Users/brandyaustin/ada/week2/grocery_store/grocery-store/support/customers.csv").each do |row|
        puts row.inspect
        # id = row[0].to_i
        # products = {}
        # products_array = row[1].split(";")
        #
        # products_array.each do |item|
        #   name, price = item.split(':')
        #   products[name] = price.to_f
      end
      all_customers << Order.new(id, products)
    end
    #return all_customers
  end

end

Grocery::Customer.all
