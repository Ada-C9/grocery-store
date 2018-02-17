module Grocery
  class OnlineOrder < Orders
    attr_accessor :customer

    def initialize(id, products, customer, status = :pending)
      id = super
      products = super
      @customer = customer
      @customer_id = customer.id
      @status = status
    end # Initialize

    def total
      super
      # TODO: Add 10 for shipping to inherited method
    end

    def add_product
      super
      # TODO: permit a new product to be added ONLY if the status is either pending or paid (no other statuses permitted) Otherwise it should raise an ArgumentError (maybe a custom one, why not?)
    end

    def self.all
      #TODO determine how this should override Order
    end

    def self.find(id)
      #TODO determine how this differs from the Order find method
    end

    def self.find_by_customer(customer_id)
      #TODO returns a list of OnlineOrder instances where the value of the customer's ID matches the passed parameter
    end

  end # OnlineOrder
end # Grocery
