require "csv"
require "awesome_print"

module Grocery
  class OnlineOrder < Order
    attr_reader :id, :customer, :status
    attr_accessor :products

    # set to pending as the default
    def initialize(id, products, customer, status = :pending)
      super(id, products)
      @customer = customer
      @status = status
    end
  end
end
