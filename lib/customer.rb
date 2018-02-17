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
      CSV.read("../support/customers.csv").each do |row|
        address = {}
        customer_id = row[0].to_i
        email = row[1]
        address[:street] = row[2]
        address[:city] = row[3]
        address[:state] = row[4]
        address[:zip_code] = row[5]

        all_customers << Customer.new(customer_id, email, address)

      end
      return all_customers
    end

    def self.find(id)
      all_customers = self.all
      all_customers.each do |customer|
        if customer.id == id
          return customer
        end
      end
      return nil
    end

  end
end
