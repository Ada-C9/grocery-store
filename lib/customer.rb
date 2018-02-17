module Grocery
  class Customer
    def initialize(id, email, address)
      @customer_id = id
      @email = email
      @address = address
    end

    def self.all
      #TODO: returns a collection of Customer instances representing all of the customers described in the CSV
    end

    def self.find(id)
      #TODO: returns an instance of Customer where the value of the id field in the CSV matches the passed parameter
    end
  end
end
