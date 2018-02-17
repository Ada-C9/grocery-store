require 'csv'
require 'awesome_print'

module Grocery

  class Customer

    attr_reader :id, :email, :address_1, :city, :state, :zip_code

    @@all_customers = []

    def initialize id, email, address_1, city, state, zip_code
      @id = id.to_i
      @email = email
      @address_1 = address_1
      @city = city
      @state = state
      @zip_code = zip_code
    end

    def self.all
      @@all_customers = []
      CSV.read("support/customers.csv").each do |customer|
        a_customer = self.new(customer[0], customer[1], customer[2], customer[3], customer[4], customer[5])
        @@all_customers << a_customer
      end
      @@all_customers
    end

    def self.find(id)
      self.all
      @@all_customers.each do |customer|
        if customer.id == id
          return customer
        end
      end
      nil
    end

  end

end
