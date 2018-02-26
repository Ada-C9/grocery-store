require "csv"
require "awesome_print"

require_relative '../lib/order'

module Grocery
  class Customer
    attr_reader :id
    attr_accessor :email, :address

    def initialize(id, email, address)
      @id = id
      @email = email
      @address = address
    end

    def self.all
      all_customers = []
      CSV.read('support/customers.csv', 'r').each do |row|
        address = {street: row[2], city: row[3], state: row[4], zip: row[5]}
        all_customers << self.new(row[0], row[1] , address)
      end
      return all_customers
    end

    def self.find(id)
      all_customers = self.all
      all_customers.each do |customer|
        if id == customer.id
          return customer
        elsif id == "first"
          return all_customers[0]
        elsif id == "last"
          return all_customers[-1]
        end
      end
      return nil
    end
  end
end
