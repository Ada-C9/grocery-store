require "csv"

module Grocery
  class Customer
    attr_reader :id, :email, :street_address, :city, :state, :zip

    def initialize(id, email, street_address, city, state, zip)
      @id = id
      @email = email
      @street_address = street_address
      @city = city
      @state = state
      @zip = zip
    end

    def self.all
      customers_array = []
      CSV.open("support/customers.csv", "r").each do |customer|
        id = customer[0].to_i
        email = customer[1]
        street_address = customer[2]
        city = customer[3]
        state = customer[4]
        zip = customer[5]
        customers_array << Customer.new(id, email, street_address, city, state, zip)
      end

      return customers_array
    end # .all method


    def self.find(id)
    end 

  end # Customer class

end # Grocery Module














#
