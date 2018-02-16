require 'csv'
require 'awesome_print'

module Grocery
  class Customer

    attr_reader :id, :email, :address

    def initialize(id, email, address)
      @id = id
      @email = email
      @address = address
    end

    # Returns a collection of Customer instances
    def self.all
      return Customer.parse_csv
    end

    # Helper method to parse data from csv file
    def self.parse_csv
      customers = []
      CSV.foreach('support/customers.csv') do |row|
        id = row[0].to_i
        email = row[1]
        address = {street: row[2], city: row[3], state: row[4], zip: row[5]}
        customers << Customer.new(id, email, address)
      end
      return customers
    end

    # Returns an instance of Customer searched by id
    def self.find(id)
      customers = Customer.all
      customers.each do |customer|
        if customer.id == id
          return customer
        end
      end
      return nil
    end

  end
end
