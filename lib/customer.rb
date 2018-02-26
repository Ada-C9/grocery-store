require 'csv'
require 'awesome_print'

module Grocery

  class Customer

    attr_reader :id, :email, :address, :city, :state, :zip

    def initialize(id, email, address, city, state, zip)
      @id = id
      @email = email
      @address = address
      @city = city
      @state = state
      @zip = zip
    end

    def self.all
      all_customers = []
      # CSV.read('../support/customers.csv', 'r').each do |row|
      CSV.read('support/customers.csv', 'r').each do |row|
        id = row[0].to_i
        email = row[1]
        address = row[2]
        city = row[3]
        state = row[4]
        zip = row[5]
        all_customers << Customer.new(id, email, address, city, state, zip)
      end
      return all_customers
    end

    def self.find(id)
      all_customers = Grocery::Customer.all
      customer_instance = all_customers.find_all { |customer| customer.id == id }
      if customer_instance.length <= 0
        return nil
      else
        return customer_instance
      end
    end

  end

end
