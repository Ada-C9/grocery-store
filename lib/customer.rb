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

    def self.all
    end

    def self.find
    end
    # instance of customer will be used within online order
  end
end
