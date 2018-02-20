require 'csv'
require 'awesome_print'

CUSTOMER_FILE_NAME = 'support/customers.csv'


module  Grocery

  class Customer

    attr_reader :id, :email, :delivery_address

    def initialize(id, email, delivery_address)
      @id = id
      @email = email
      @delivery_address = delivery_address
    end
