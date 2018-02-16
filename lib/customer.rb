require 'csv'
require 'pry'



# Customer
#
# Create a Customer class within the Grocery module.
#
# Each new Customer should include the following attributes:
#
# ID
# email address
# delivery address information
#
# The Customer should also have the following class methods:
#
# self.all - returns a collection of Customer instances, representing all of
# the Customer described in the CSV. See below for the CSV file specifications
# self.find(id) - returns an instance of Customer where the value of the id
# field in the CSV matches the passed parameter.
# CSV Data File
#
# The data for the customer CSV file consists of:
#
# Field	Type	Description
# Customer ID	Integer	A unique identifier corresponding to the Customer
# Email	String	The customer's e-mail address
# Address 1	String	The customer's street address
# City	String	The customer's city
# State	String	The customer's state
# Zip Code	String	The customer's zip code



module Grocery
  class Customer
    attr_reader :id, :email, :address
    @@all = []

    def initialize(initial_id, initial_email, initial_address)
      @id = initial_id
      @email = initial_email
      @address = initial_address # type: hash
    end

    #
    # def self.all
    #   # if @@all.empty? # TODO: uncomment these when done!!
    #   CSV.read("../support/customers.csv").each do |customer_line|
    #
    #
    #
    #
    #
    #     @@all << Customer.new(customer_id, customer_email, customer_address_hash)
    #   end
    #   return @@all
    # end
    #
    # #
    # def self.find(requested_id)
    #   return @@all.find { |customer| customer.id == requested_id }
    # end

  end
end
