require 'csv'
require 'awesome_print'

module Grocery

  class Customer

    attr_reader :id, :email, :address_1, :city, :state, :zip_code

    @@all_customers = []
# initializes all information from CSV as instance variables
    def initialize id, email, address_1, city, state, zip_code
      @id = id.to_i
      @email = email
      @address_1 = address_1
      @city = city
      @state = state
      @zip_code = zip_code
    end
# method to return an array that contains all instances of customers in CSV
    def self.all
      @@all_customers = []
      CSV.read("support/customers.csv").each do |customer|
        a_customer = self.new(customer[0], customer[1], customer[2], customer[3], customer[4], customer[5])
        @@all_customers << a_customer
      end
      @@all_customers
    end
# method to find a specific customers info by their id
    def self.find(id)
      self.all
      @@all_customers.each do |customer|
        if customer.id == id
          return customer
        end
      end
      raise ArgumentError
    end

  end

end
