require 'pry'

module Grocery
  class Customer
    attr_reader :id
    attr_accessor :email, :address

    FILE_NAME = 'lib/customers.csv'

    def initialize(id, email, address)
      @id = id
      @email = email
      @address = address
    end

    def self.all
      CSV.open(FILE_NAME, "r").each do |customer|
      end
    end
    
  end # customer

end # grocery
