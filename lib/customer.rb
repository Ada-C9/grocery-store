require 'csv'
require 'awesome_print'

module Grocery
  class Customer
    attr_reader :id, :email, :address

    @@all_customers = []

    def initialize(id, email, address)
      @id = id
      @email = email
      @address = address
    end

    def self.all
      @@all_customers = []
      CSV.foreach("../support/customers.csv") do |row|
        emails = []
        emails.push(row[2], row[3], row[4], row[5])
        @@all_customers.push([row[0].to_i, row[1], emails])
      end
      return @@all_customers
    end

    def self.find

    end
    # instance of customer will be used within online order
  end
end
