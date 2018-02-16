require 'csv'
require 'pry'

module Grocery

  CUSTOMER_FILE = 'support/customers.csv'

  class Customer
    attr_reader :id
    attr_accessor :email, :address


    def initialize(id, email, address)
      @id = id
      @email = email
      @address = address
    end

    def self.all
      all_customers = Array.new
      CSV.open(CUSTOMER_FILE, "r").each do |customer|
        address = customer[2] + " " + customer[3] + " " + customer[4] + " " + customer[5]
        new_customer = self.new(customer[0].to_i, customer[1], address)
        all_customers << new_customer
      end
      return all_customers
    end

  end # customer

end # grocery

# binding.pry
