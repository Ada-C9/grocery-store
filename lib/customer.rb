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
    end

    # Helper method to parse data from csv file
    def parse_csv
    end

    # Returns an instance of Customer
    def self.find(id)
    end

  end
end
