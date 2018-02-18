require 'csv'
# require 'pry'

module Grocery
  class Customer
    attr_reader :id, :email, :address

    @@all_customers = []

    def initialize(initial_id, initial_email, initial_address)
      @id = initial_id
      @email = initial_email
      @address = initial_address # type: hash
      # Grocery::Customer.all
    end


    def self.all
      if @@all_customers.empty? # TODO: uncomment these when done!!
        CSV.read("../support/customers.csv").each do |customer_line|
          customer_id = customer_line[0].to_i
          customer_email = customer_line[1]
          customer_address_hash = {}
          customer_address_hash[:street] = customer_line[2]
          customer_address_hash[:city] = customer_line[3]
          customer_address_hash[:state] = customer_line[4]
          customer_address_hash[:zip_code] = customer_line[5]
          @@all_customers << Customer.new(customer_id, customer_email, customer_address_hash)
        end
      end
      return @@all_customers
    end

    #
    def self.find(requested_id)
      return all.find { |customer| customer.id == requested_id }
    end

  end
end
