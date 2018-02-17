require 'csv'
require_relative './order'
require_relative './customer'




module Grocery

  class OnlineOrder < Order
    attr_reader :customer, :fulfillment, :id, :products
    @@all = []

    def initialize(initial_id, initial_products, initial_customer, initial_fulfillment)
      super(initial_id, initial_products)
      @customer = initial_customer
      @fulfillment = initial_fulfillment

        # A fulfillment status (stored as a Symbol)
        # pending, paid, processing, shipped or complete
        # If no status is provided, it should set to pending as the default
    end

    def total
      return 10.0 + super
    end

    def add_product
      if @fulfillment_status != :pending || @fulfillment_status != :paid
        raise ArgumentError.new("Can only add product when online order is pending or paid.")
      end
      # do I have to call super at this point??
    end


  end

end


# Create an OnlineOrder class which will inherit behavior from the Order class.
#
# Each new OnlineOrder should include all attributes from the Order class as
# well as the following additional attributes:
#
# A customer object
# A fulfillment status (stored as a Symbol)
# pending, paid, processing, shipped or complete
# If no status is provided, it should set to pending as the default
# The OnlineOrder should include the following updated functionality:
#
# The total method should be the same, except it will add a $10 shipping fee
# The add_product method should be updated to permit a new product to be added
#  ONLY if the status is either pending or paid (no other statuses permitted)
# Otherwise, it should raise an ArgumentError (Google this!)
# The OnlineOrder should also have the following class methods:
#
# self.all - returns a collection of OnlineOrder instances, representing all of
# the OnlineOrders described in the CSV. See below for the CSV file
# specifications
# Question Ask yourself, what is different about this all method versus the
# Order.all method? What is the same?
# self.find(id) - returns an instance of OnlineOrder where the value of the
# id field in the CSV matches the passed parameter. -Question Ask yourself,
# what is different about this find method versus the Order.find method?
# self.find_by_customer(customer_id) - returns a list of OnlineOrder instances
# where the value of the customer's ID matches the passed parameter.
# CSV Data File
#
# The data for the online order CSV file consists of:
#
# Field	Type	Description
# ID	Integer	A unique identifier for that Online Order
# Products	String	The list of products in the following format: name:price;nextname:nextprice
# Customer ID	Integer	A unique identifier corresponding to a Customer
# Status	String	A string representing the order's current status
