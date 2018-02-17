require "csv"
require "awesome_print"

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
        address = row[2] + "," + row[3] + "," + row[4] + "," + row[5]
        all_customers << self.new(row[0], row[1] , address)
      end
      return all_customers
    end
  end
end
