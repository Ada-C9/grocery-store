require "csv"
require "awesome_print"

module Grocery
  class Customer
    attr_reader :id, :email, :address, :city, :state, :zip

    def initialize(id, email, address, city, state, zip)
      @id = id
      @email = email
      @address = address
      @city = city
      @state = state
      @zip = zip
    end

    def self.all
      all_customers = []
      CSV.read("support/customers.csv", 'r').each do |customer|
        id = customer[0].to_i
        email = customer[1]
        address = customer[2]
        city = customer[3]
        state = customer[4]
        zip = customer[5]
        customer = Customer.new(id, email, address, city, state, zip)
        all_customers << customer
      end
      return all_customers
    end

    def self.find(id)
      found_customer = nil
      self.all.each do |customer|
        if customer.id == id
          found_customer = customer
        end
      end
      if found_customer != nil
        return found_customer
      else
        raise ArgumentError.new("customer id does not exist")
      end
    end
  end
end
