require 'csv'
require 'awesome_print'

CUSTOMER_FILE = 'support/customers.csv'

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

    def self.all(csv_file=CUSTOMER_FILE)
      csv_array = CSV.read(csv_file, 'r')
      all_customers = []
      csv_array.each do |customer|
        id = customer[0].to_i
        email = customer[1]
        address = customer[2]
        city = customer[3]
        state = customer[4]
        zip = customer[5]
        new_customer = Customer.new(id, email, address, city, state, zip)
        all_customers << new_customer
      end
      return all_customers
    end

    def self.find(id, csv_file=CUSTOMER_FILE)
      Customer.all(csv_file).each do |customer|
        if customer.id == id
          return customer
        end
      end
      raise ArgumentError.new("Customer #{id} could not be found in the customer database.")
    end
  end
end
