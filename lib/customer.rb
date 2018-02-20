require 'csv'

CUSTOMER_FILE = 'support/customers.csv'

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

    # reads csv file (set to customers.csv by default if no other file is given)
    # iterates through each line (array) of the csv file to parse the customer data
    # for each line, creates a new instance of the Customer class and adds it to an array of all Customer instances
    def self.all(csv_file=CUSTOMER_FILE)
      csv_array = CSV.read(csv_file, 'r')
      all_customers = []
      csv_array.each do |customer|
        id = customer[0].to_i
        email = customer[1]
        address = customer[2]
        city = customer[3]
        state = customer[4]
        zip = customer[5]
        new_customer = Customer.new(id, email, address, city, state, zip)
        all_customers << new_customer
      end
      return all_customers
    end

    # iterates through the array returned by the self.all method to find a customer with an id equal to the provided argument
    # raises an ArgumentError if the provided id does not match an id in the array returned by self.all
    def self.find(id, csv_file=CUSTOMER_FILE)
      Customer.all(csv_file).each do |customer|
        if customer.id == id
          return customer
        end
      end
      raise ArgumentError.new("Customer #{id} could not be found in the customer database.")
    end
  end
end
