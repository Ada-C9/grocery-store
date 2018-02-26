#Lily Sky Grocery Store - Customer
#Ada C9

require 'awesome_print'
require 'csv'
require_relative 'order.rb'

module Grocery
  class Customer
    attr_reader :id, :email, :address

    def initialize(id, email, address)
      @id = id
      @email = email
      @address = address
    end

    def self.all_customers
      customers = []
      CSV.read("support/customers.csv").each do |line|
        address = []
      address << line[2..5].join(", ")
      customers << Grocery::Customer.new(line[0], line[1], address)
      end
      return customers
    end

    def self.find_customer(id)
      Customer.all_customers.each do |person|
        if person.id == id
          return person
        end
      end
      return nil
    end

  end
# ap Customer.all_customers.length
end
